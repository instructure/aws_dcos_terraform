module "cred_writer" {
  source = "../ecr_cred_lambda"
  env_name = "${var.env_name}"
  docker_cred_bucket = "${var.docker_cred_bucket}"
  registry_id = "${var.account_id}"
}

module "repos" {
  source = "../ecr_repo"
  namespace = "${var.namespace}"
  names = "${var.names}"
  account_id = "${var.account_id}"
  users = "${var.users}"
  pull_principal = "${var.pull_principal}"
}


