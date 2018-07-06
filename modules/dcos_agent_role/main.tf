data "aws_iam_policy_document" "assume_role_policy" {
  statement {
    actions = [
      "sts:AssumeRole",
    ]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com", "ssm.amazonaws.com", "autoscaling.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "agent_role" {
  name = "${coalesce(var.role_name, format("dcos-%s-agent-%s", var.cluster_name, var.agent_type))}"

  assume_role_policy = "${data.aws_iam_policy_document.assume_role_policy.json}"
}

data "aws_iam_policy_document" "primary" {
  statement {
    actions = [
      "ec2:CreateTags",
      "ec2:DescribeTags",
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
      "ec2:DescribeSnapshotAttribute",
    ]

    resources = [
      "*",
    ]
  }

  statement {
    actions = [
      "s3:GetObject*",
      "s3:PutObject*",
    ]

    resources = [
      "arn:aws:s3:::${var.work_bucket}/${var.cluster_name}/${var.work_prefix}/*",
    ]
  }
}

resource "aws_iam_role_policy" "primary" {
  name = "dcos-${var.cluster_name}-${var.agent_type}-agent-primary"
  role = "${aws_iam_role.agent_role.id}"

  policy = "${data.aws_iam_policy_document.primary.json}"
}

resource "aws_iam_instance_profile" "agent_profile" {
  name = "dcos-${var.cluster_name}-${var.agent_type}-agent-primary"
  role = "${aws_iam_role.agent_role.name}"
}
