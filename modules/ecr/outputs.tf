output "lambda_role_id" {
  value = "${module.cred_writer.lambda_role_id}"
}

output "lambda_role_arn" {
  value = "${module.cred_writer.lambda_role_arn}"
}

output "lambda_role_name" {
  value = "${module.cred_writer.lambda_role_name}"
}

output "lambda_arn" {
  value = "${module.cred_writer.lambda_arn}"
}

output "repo_names" {
  value = "${module.repos.repo_names}"
}
