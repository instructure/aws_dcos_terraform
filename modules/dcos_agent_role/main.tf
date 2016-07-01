
resource "aws_iam_role" "agent_role" {
  name = "${coalesce(var.role_name, format("%s-dcos-agent-%s", var.env_name, var.agent_type))}"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_role_policy" "agent_role_primary" {
  name = "${var.env_name}-${var.agent_type}-agent-primary-policy"
  role = "${aws_iam_role.agent_role.id}"
  policy = <<EOF
{
  "Version" : "2012-10-17",
  "Statement": [
    {
      "Resource": "*",
      "Action": [
        "ec2:CreateTags",
        "ec2:DescribeInstances",
        "ec2:CreateVolume",
        "ec2:DeleteVolume",
        "ec2:AttachVolume",
        "ec2:DetachVolume",
        "ec2:DescribeVolumes",
        "ec2:DescribeVolumeStatus",
        "ec2:DescribeVolumeAttribute",
        "ec2:CreateSnapshot",
        "ec2:CopySnapshot",
        "ec2:DeleteSnapshot",
        "ec2:DescribeSnapshots",
        "ec2:DescribeSnapshotAttribute"
      ],
      "Effect": "Allow"
    },
    {
      "Resource": ["arn:aws:s3:::${var.work_bucket}/${var.work_prefix}/*"],
      "Action": [
        "s3:GetObject*",
        "s3:PutObject*"
      ],
      "Effect": "Allow"
    }
  ]
}
EOF
}

resource "aws_iam_instance_profile" "agent_profile" {
  name = "${var.env_name}-${var.agent_type}-agent-profile"
  roles = ["${aws_iam_role.agent_role.name}"]
}
