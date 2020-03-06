data "aws_iam_policy_document" "assume_role_policy" {
  statement {
    actions = [
      "sts:AssumeRole",
    ]

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "ecr_cred_writer_role" {
  name = "${var.cluster_name}-ecr-cred-writer"

  assume_role_policy = "${data.aws_iam_policy_document.assume_role_policy.json}"
}

locals {
  docker_cred_def = "${format("%s/docker/creds.tar.gz", var.cluster_name)}"
  docker_cred_key = "${coalesce(var.docker_cred_key, local.docker_cred_def)}"
}

data "aws_iam_policy_document" "primary" {
  statement {
    actions = [
      "ecr:GetAuthorizationToken",
    ]

    resources = [
      "*",
    ]
  }

  statement {
    actions = [
      "s3:PutObject*",
    ]

    resources = [
      "arn:aws:s3:::${var.docker_cred_bucket}/${local.docker_cred_key}",
    ]
  }
}

resource "aws_iam_role_policy" "ecr_cred_write_policy" {
  name = "${var.cluster_name}-write-to-ecr"
  role = "${aws_iam_role.ecr_cred_writer_role.id}"

  policy = "${data.aws_iam_policy_document.primary.json}"
}

data "template_file" "lambda_conf" {
  template = <<EOF
{
  "targetBucket": "${var.docker_cred_bucket}",
  "targetKey": "${local.docker_cred_key}",
  "registryId": "${var.registry_id}"
}
EOF
}

module "ecr_writer" {
  source         = "github.com/instructure/tf_versioned_lambda?ref=final-0.11//modules/node"
  name           = "${var.cluster_name}_ecr_cred_writer"
  role           = "${coalesce(var.lambda_role, aws_iam_role.ecr_cred_writer_role.arn)}"
  handler        = "${var.handler_name}"
  runtime        = "${var.runtime}"
  package_bucket = "${var.docker_cred_bucket}"
  package_prefix = "${var.cluster_name}/docker/builds"
  lambda_dir     = "${format("%s/scripts/ecr_writer", path.module)}"
  config_string  = "${data.template_file.lambda_conf.rendered}"
  build_script   = "${var.lambda_build_script}"
}

resource "aws_cloudwatch_event_rule" "write_creds_tick" {
  name                = "write-ecr-creds-tick"
  description         = "Fires event on tick"
  schedule_expression = "rate(${var.num_hours_tick} hours)"
}

resource "aws_lambda_permission" "cw_call_ecr_cred_writer" {
  statement_id  = "AllowExecutionFromCloudWatch"
  action        = "lambda:InvokeFunction"
  function_name = "${module.ecr_writer.lambda_name}"
  principal     = "events.amazonaws.com"
  source_arn    = "${aws_cloudwatch_event_rule.write_creds_tick.arn}"
}

resource "aws_cloudwatch_event_target" "write_creds_target" {
  rule      = "${aws_cloudwatch_event_rule.write_creds_tick.name}"
  target_id = "ecr_cred_writer"
  arn       = "${module.ecr_writer.lambda_arn}"
}
