resource "aws_ecr_repository" "repo" {
  name = "${format("%s/%s", var.namespace, element(split(",", var.names), count.index))}"
  count = "${length(split(",", var.repo_names))}"
}

resource "aws_ecr_repository_policy" "ecr_access" {
  count = "${length(split(",", var.repo_names))}"
  repository = "${element(aws_ecr_repository.repo.*.name, count.index)}"
  policy = <<EOF
{
  "Version": "2008-10-17",
  "Statement": [
    {
      "Sid": "allow_all_pull",
      "Effect": "Allow",
      "Principal": "*",
      "Action": [
        "ecr:GetDownloadUrlForLayer",
        "ecr:BatchGetImage",
        "ecr:BatchCheckLayerAvailability",
        "ecr:GetRepositoryPolicy",
        "ecr:ListImages"
      ]
    },
    {
      "Sid": "allow_specific_pull",
      "Effect": "Allow",
      "Principal": {
        "AWS": [
          ${join(",", formatlist("\"arn:aws:iam::${var.account_id}:user/%s\"", compact(concat(var.pull_principal, split(",", var.users)))))}
        ]
      },
      "Action": [
        "ecr:GetDownloadUrlForLayer",
        "ecr:BatchGetImage",
        "ecr:BatchCheckLayerAvailability",
        "ecr:PutImage",
        "ecr:InitiateLayerUpload",
        "ecr:UploadLayerPart",
        "ecr:CompleteLayerUpload",
        "ecr:DescribeRepositories",
        "ecr:GetRepositoryPolicy",
        "ecr:ListImages",
        "ecr:BatchDeleteImage"
      ]
    }
  ]
}
EOF
}
