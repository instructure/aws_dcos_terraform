variable "env_name" {}
// the bucket to write creds to
variable "docker_cred_bucket" {}
// by default, we write to /docker/${env_name}/creds.tar.gz
// but you can set this and write to a different path in s3
variable "docker_cred_key" {
  default = ""
}
// these two can be overriden to 0 and a valid zip file
// to upload a custom chunk of lambda code rathen than using
// the included lambda code
variable "use_builtin_lambda" {
  default = 1
}
variable "lambda_package" {
  default = ""
}
// the name of the package to write, not really useful to override
variable "lambda_package_name" {
  default = "write_creds.zip"
}
// then name of the handler, useful if you want to send in your own implementation
variable "handler_name" {
  default = "write_cred.handler"
}
// override the role to run the lambda under, you must take care
// of making sure the role can by assumed by lambda and
// also have the ability to get auth from ECR and write to s3
variable "lambda_role" {
  default = ""
}

// how often to write the creds out
variable "num_hours_tick" {
  default = 4
}
// the runtime to run under
variable "runtime" {
  default = "nodejs4.3"
}
variable "registry_id" {
  description = "the registry_id is the account_id"
}
