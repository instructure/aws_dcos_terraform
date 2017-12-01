variable "region" {
  description = "the aws region to deploy in"
  default     = "us-east-1"
}

variable "region_azs" {
  type        = "list"
  description = "lsit of AZs to deploy into"
  default     = ["a", "b", "c"]
}

variable "network" {
  description = "the cidr of your vpc"
}

variable "vpc_id" {}

variable "instance_subnets" {
  description = "the subnets to launch the public agent instances into"
  type        = "list"
}

variable "elb_subnets" {
  description = "the subnets to launch the public ELB into"
  type        = "list"
}

variable "cluster_name" {
  description = "the name of the environment"
}

variable "coreos_ami" {
  description = "the ami to use (must be coreos), defaults to latest core-os image"
  default     = ""
}

variable "instance_type" {
  description = "the instance to be used"
  default     = "r3.xlarge"
}

variable "key_name" {
  description = "the name of the IAM ssh key used"
}

variable "default_security_group" {
  description = "the default security group name (contains common settings for all instances)"
}

# if you want the the lb associated to not actually be public... set this
variable "internal_lb" {
  default = false
}

variable "extra_security_groups" {
  description = "any extra security groups to be applied"
  type        = "list"
  default     = []
}

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

# the path to a cloud config, if not defined, uses the default template. See the default template for
# details and use that as a source for customizations
variable "cloud_config_template" {
  default = ""
}

# the work bucket for temporary objects
variable "work_bucket" {}

# the work prefix to use for temporary work objects
variable "work_prefix" {
  default = "work"
}

variable "bucket_name" {
  description = "the primary bucket for bootstrap"
}

variable "dcos_version" {
  description = "the version of dcos"
}

variable "dcos_install_path" {
  description = "the s3 path where the DCOS install is located"
}

variable "http_instance_port" {
  default     = "80"
  description = "from port 80 on the LB, which backend port to hit"
}

variable "https_instance_port" {
  default     = "443"
  description = "from port 443 on the LB, which backend port to hit"
}

variable "idle_timeout" {
  default     = 60
  description = "The number of seconds before timing out idle sockets"
}
