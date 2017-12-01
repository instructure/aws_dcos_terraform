variable "region" {
  default = "us-east-1"
}

variable "cluster_name" {
  description = "the name of this cluster"
}

variable "num_masters" {
  default     = "3"
  description = "the number of masters"
}

variable "bucket" {
  description = "the bucket to upload to"
}

variable "master_elb_dnsname" {}

variable "dcos_version" {
  description = "the version of DCOS to install, must be a stable released version (otherwise use dcos_url and arbitrary version here)"
}

variable "dcos_url" {
  description = "the dcos_generate_config.sh package to use, defaults to https://downloads.dcos.io/dcos/stable/${DCOS_VERSION}/dcos_generate_config.sh"
  default     = ""
}

variable "build_script_path" {
  description = "the path to a custom build script for the bootstrap package"
  default     = ""
}

variable "finished_file" {
  default = "__SUCCESS"
}

variable "role_arn" {
  description = "a role to assume when uploading the file"
  default     = ""
}
