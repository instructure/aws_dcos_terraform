resource "aws_ecr_repository" "repo" {
  name  = "${format("%s/%s", var.namespace, element(var.repo_names, count.index))}"
  count = "${length(var.repo_names)}"
}

# the monstorsity of a interpolation looks really bad... but its actually not too horrible
# if push_principal is defined, we wrap it in quotes and the replace does nothing
# if it isn't define, we still wrap in quotes but then replace empty quotes with an empty string
# so we fall back to users, in which case we split, format in an ARN, and rejoin with comma
resource "aws_ecr_repository_policy" "ecr_access" {
  count      = "${length(var.repo_names)}"
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
      "Sid": "allow_specific_push",
      "Effect": "Allow",
      "Principal": {
        "AWS": [
          ${coalesce(replace(format("\"%s\"", var.push_principal), "\"\"", ""), join(", ", formatlist("\"arn:aws:iam::${var.account_id}:user/%s\"", var.users)))}
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
