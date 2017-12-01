module "cred_writer" {
  source             = "../ecr_cred_lambda"
  cluster_name       = "${var.cluster_name}"
  docker_cred_bucket = "${var.docker_cred_bucket}"
  registry_id        = "${var.account_id}"
}

module "repos" {
  source         = "../ecr_repo"
  namespace      = "${var.namespace}"
  repo_names     = "${var.repo_names}"
  account_id     = "${var.account_id}"
  users          = "${var.users}"
  push_principal = "${var.push_principal}"
}
