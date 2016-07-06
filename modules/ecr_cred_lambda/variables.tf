variable "env_name" {}

variable "docker_cred_bucket" {
  description = "the bucket to write creds to"
}

variable "docker_cred_key" {
  description = "by default, we write to /docker/{env_name}/creds.tar.gz, but you can set this and write to a different path in s3"
  default     = ""
}

variable "lambda_build_script" {
  description = "override script used to build and upload a lambda function"
  default     = ""
}

variable "handler_name" {
  description = "then name of the handler, useful if you want to send in your own implementation"
  default     = "write_cred.handler"
}

variable "lambda_role" {
  description = "override the role to run the lambda under, you must take care of making sure the role can by assumed by lambda and also have the ability to get auth from ECR and write to s3"
  default     = ""
}

variable "num_hours_tick" {
  description = "how often to write the creds out"
  default     = 4
}

variable "runtime" {
  description = "the runtime of the lambda function"
  default     = "nodejs4.3"
}

variable "registry_id" {
  description = "the registry_id is the account_id"
}
