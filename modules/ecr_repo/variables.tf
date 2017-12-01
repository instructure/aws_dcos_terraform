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
  description = "a list of users to allow push access"
  type        = "list"
}

variable "push_principal" {
  default     = ""
  description = "allows for specifiy a wildcard of who can push"
}
