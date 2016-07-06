variable "namespace" {
  description = "the namespace for the repo"
}

variable "repo_names" {
  description = "comma seperated list of repo names, under the namespace"
}

variable "account_id" {
  description = "the account in aws"
}

variable "users" {
  description = "a comma seperated list of users to allow push access"
}

variable "push_principal" {
  default     = ""
  description = "allows for specifiy a wildcard of who can push"
}
