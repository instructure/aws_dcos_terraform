resource "aws_iam_role" "ecr_cred_writer_role" {
  name = "${var.env_name}-ecr-cred-writer"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "template_file" "lambda_conf" {
  template = <<EOF
{
  "targetBucket": "${var.docker_cred_bucket}",
  "targetKey": "${coalesce(var.docker_cred_key, format("docker/%s/creds.tar.gz", var.env_name))}",
  "registryId": "${var.registry_id}"
}
EOF
}

resource "null_resource" "inject_build" {
  triggers {
    config_val = "${template_file.lambda_conf.rendered}"
  }

  provisioner "local-exec" {
    command = "${coalesce(var.lambda_build_script, format("%s/files/ecr_writer/build_docker.sh", path.module))} ${var.env_name} '${template_file.lambda_conf.rendered}' ${format("s3://%s/docker/%s/%s", var.docker_cred_bucket, var.env_name, base64sha256(template_file.lambda_conf.rendered))}"
  }
}

resource "aws_iam_role_policy" "ecr_cred_write_policy" {
  name = "${var.env_name}-write-to-ecr"
  role = "${aws_iam_role.ecr_cred_writer_role.id}"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "ecr:GetAuthorizationToken"
      ],
      "Resource": "*"
    },
    {
      "Effect": "Allow",
      "Action": [
        "s3:PutObject"
      ],
     "Resource": ["arn:aws:s3:::${var.docker_cred_bucket}/${coalesce(var.docker_cred_key, format("docker/%s/creds.tar.gz", var.env_name))}"]
    }
  ]
}
EOF
}

resource "aws_lambda_function" "ecr_cred_writer" {
  depends_on = ["null_resource.inject_build"]
  s3_bucket  = "${var.docker_cred_bucket}"
  s3_key     = "docker/${var.env_name}/${base64sha256(template_file.lambda_conf.rendered)}"

  # work around https://github.com/hashicorp/terraform/issues/5673
  s3_object_version = "null"
  function_name     = "${var.env_name}-ecr-cred-writer"
  handler           = "${var.handler_name}"
  role              = "${coalesce(var.lambda_role, aws_iam_role.ecr_cred_writer_role.arn)}"
  runtime           = "${var.runtime}"
}

resource "aws_cloudwatch_event_rule" "write_creds_tick" {
  name                = "write-ecr-creds-tick"
  description         = "Fires event on tick"
  schedule_expression = "rate(${var.num_hours_tick} hours)"
}

resource "aws_lambda_permission" "cw_call_ecr_cred_writer" {
  statement_id  = "AllowExecutionFromCloudWatch"
  action        = "lambda:InvokeFunction"
  function_name = "${aws_lambda_function.ecr_cred_writer.function_name}"
  principal     = "events.amazonaws.com"
  source_arn    = "${aws_cloudwatch_event_rule.write_creds_tick.arn}"
}

resource "aws_cloudwatch_event_target" "write_creds_target" {
  rule      = "${aws_cloudwatch_event_rule.write_creds_tick.name}"
  target_id = "ecr_cred_writer"
  arn       = "${aws_lambda_function.ecr_cred_writer.arn}"
}
