variable "aws_region" {
  default = "us-east-1"
}
# the dns endpoint of the master internal ELB,
# this gets built into the config.yaml for bootstrapping
variable "master_elb_dns" {}
# the name of the environment
variable "env_name" {}
# the name of the exhibitor bucket
# this gets built into the config.yaml for bootstrapping
variable "exhibitor_bucket" {}
# the name of the boostrap bucket
# this is where we copy the boostraped installer for downloading
variable "bootstrap_bucket" {}
# the name of the boostrap file, this shouldn't really need to be
# overriden
variable "bootstrap_dl_file" {
  default = "dcos_install.sh"
}
variable "finished_file" {
  default = "__SUCCESS"
}
variable "build_script_path" {
  description = "the path to a custom build script for the bootstrap package"
  default = ""
}
