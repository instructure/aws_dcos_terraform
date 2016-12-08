# the aws region to deploy in
variable "aws_region" {
  default = "us-east-1"
}

# comma seperated list of the AZs to deploy into
variable "region_azs" {
  default = "a,b,c"
}

variable "network" {}

variable "vpc_id" {}

# the public subnets to launch UI ELB, comma seperated, must be the same number of elements as region_azs
variable "public_subnets" {}

# the subnets to launch the master instances into
variable "private_subnets" {}

# the name of the environment
variable "env_name" {}

# the ami to use (must be coreos)
variable "coreos_ami" {
  default = "ami-6160910c"
}

# the instance to be used
variable "instance_type" {
  default = "r3.xlarge"
}

# the name of the IAM ssh key used
variable "key_name" {}

# the default security group name (contains common settings for all instances)
variable "default_security_group" {}

# any extra security groups to be applied, comma seperated
variable "extra_security_groups" {}

# the size of the root volume
variable "root_volume_size" {
  default = 20
}

# the max number of instances (for master ASGs, this MUST agree with min and desired)
variable "max_size" {
  default = 3
}

# the min number of instances (for master ASGs, this MUST agree with max and desired)
variable "min_size" {
  default = 3
}

# the base number of instances (for master ASGs, this MUST agree with max and min)
variable "desired_capacity" {
  default = 3
}

# The id of the internal lb
variable "master_internal_lb" {}

# the path to a cloud config, if not defined, uses the default template. See the default template for
# details and use that as a source for customizations
variable "cloud_config_template" {
  default = ""
}

# the url to the DCOS package to download
variable "dcos_install_url" {}

# the exhibitor bucket
variable "exhibitor_bucket" {}

# the work bucket for temporary objects
variable "work_bucket" {}

# the work prefix to use for temporary work objects
variable "work_prefix" {
  default = "work"
}

variable "idle_timeout" {
  default     = 60
  description = "The number of seconds before timing out idle sockets"
}
