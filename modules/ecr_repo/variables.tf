variable "namespace" {
  description = "the namespace for the repo"
}
variable "names" {
  description = "comma seperated list of repo names, under the namespace"
}
variable "account_id" {
  description = "the account in aws"
}
variable "users" {
  description = "a comma seperated list of users to allow push access"
}
variable "pull_principal" {
  default = ""
  description = "allows for specifiy a full IAM principal"
}
