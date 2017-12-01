variable "cluster_name" {}

// the bucket to write creds to
variable "docker_cred_bucket" {
  description = "bucket to write docker creds to"
}

variable "namespace" {
  description = "the namespace for the repo"
}

variable "repo_names" {
  type        = "list"
  description = "list of repo names, under the namespace"
}

variable "account_id" {
  description = "the account in aws"
}

variable "users" {
  type        = "list"
  description = "a list of users to allow push access, if you won't want to whitelist specific users set to empty string (\"\") and set push_principal to *"
}

variable "push_principal" {
  default     = ""
  description = "specify * for allowing all users to pull images"
}
