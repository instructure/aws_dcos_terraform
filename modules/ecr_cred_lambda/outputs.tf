output "lambda_role_id" {
  value = "${aws_iam_role.ecr_cred_writer_role.id}"
}
output "lambda_role_arn" {
  value = "${aws_iam_role.ecr_cred_writer_role.arn}"
}
output "lambda_role_name" {
  value = "${aws_iam_role.ecr_cred_writer_role.name}"
}
output "lambda_arn" {
  value = "${aws_lambda_function.ecr_cred_writer.arn}"
}

