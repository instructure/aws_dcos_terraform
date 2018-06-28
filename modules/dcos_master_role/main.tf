data "aws_iam_policy_document" "assume_role_policy" {
  statement {
    actions = [
      "sts:AssumeRole",
    ]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com", "ssm.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "master_role" {
  name = "${coalesce(var.role_name, format("dcos-%s-master", var.cluster_name))}"

  assume_role_policy = "${data.aws_iam_policy_document.assume_role_policy.json}"
}

data "aws_iam_policy_document" "primary" {
  statement {
    actions = [
      "s3:GetBucketPolicy",
      "s3:ListBucket",
      "s3:ListBucketMultipartUploads",
      "s3:ListMultipartUploadParts",
    ]

    resources = [
      "arn:aws:s3:::${var.exhibitor_bucket}",
    ]
  }

  statement {
    actions = [
      "s3:AbortMultipartUpload",
      "s3:DeleteObject",
      "s3:GetBucketAcl",
      "s3:GetObject",
      "s3:GetObjectAcl",
      "s3:ListBucketMultipartUploads",
      "s3:ListMultipartUploadParts",
      "s3:PutObject",
      "s3:PutObjectAcl",
    ]

    resources = [
      "arn:aws:s3:::${var.exhibitor_bucket}/exhibitor_states/${var.cluster_name}",
      "arn:aws:s3:::${var.exhibitor_bucket}/exhibitor_states/${var.cluster_name}*",
      "arn:aws:s3:::${var.exhibitor_bucket}/exhibitor/*",

      // TODO: We shouldn't need this last entry... but we do, figure out what exhibitor is doing that causes all the havoc
      "arn:aws:s3:::${var.exhibitor_bucket}/*",
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

  statement {
    actions = [
      "ec2:DescribeKeyPairs",
      "ec2:DescribeSubnets",
      "ec2:DescribeTags",
      "autoscaling:DescribeLaunchConfigurations",
      "autoscaling:UpdateAutoScalingGroup",
      "autoscaling:DescribeAutoScalingGroups",
      "autoscaling:DescribeScalingActivities",
      "elasticloadbalancing:DescribeLoadBalancers",
    ]

    resources = [
      "*",
    ]
  }
}

resource "aws_iam_role_policy" "master_role_primary" {
  name = "${var.cluster_name}-master-primary-policy"
  role = "${aws_iam_role.master_role.id}"

  policy = "${data.aws_iam_policy_document.primary.json}"
}

resource "aws_iam_instance_profile" "master_profile" {
  name = "${var.cluster_name}-master-profile"
  role = "${aws_iam_role.master_role.name}"
}
