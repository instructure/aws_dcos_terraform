
resource "aws_iam_role" "master_role" {
  name = "${coalesce(var.role_name, format("%s-dcos-master", var.env_name))}"
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

resource "aws_iam_role_policy" "master_role_primary" {
  name = "${var.env_name}-master-primary-policy"
  role = "${aws_iam_role.master_role.id}"
  policy = <<EOF
{
  "Version" : "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "s3:AbortMultipartUpload",
        "s3:DeleteObject",
        "s3:GetBucketAcl",
        "s3:GetBucketPolicy",
        "s3:GetObject",
        "s3:GetObjectAcl",
        "s3:ListBucket",
        "s3:ListBucketMultipartUploads",
        "s3:ListMultipartUploadParts",
        "s3:PutObject",
        "s3:PutObjectAcl"
      ],
      "Resource": [
        "arn:aws:s3:::${var.exhibitor_bucket}",
        "arn:aws:s3:::${var.exhibitor_bucket}/*"
      ]
    },
    {
      "Resource": "*",
      "Action": [
          "ec2:DescribeKeyPairs",
          "ec2:DescribeSubnets",
          "autoscaling:DescribeLaunchConfigurations",
          "autoscaling:UpdateAutoScalingGroup",
          "autoscaling:DescribeAutoScalingGroups",
          "autoscaling:DescribeScalingActivities",
          "elasticloadbalancing:DescribeLoadBalancers"
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

resource "aws_iam_instance_profile" "master_profile" {
  name = "${var.env_name}-master-profile"
  roles = ["${aws_iam_role.master_role.name}"]
}
