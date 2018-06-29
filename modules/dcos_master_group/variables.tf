variable "region" {
  default = "us-east-1"
}

variable "region_azs" {
  type        = "list"
  default     = ["a", "b", "c"]
  description = "lits of AZs to deploy into"
}

variable "network" {
  description = "cidr of your VPC"
}

variable "vpc_id" {}

variable "public_subnets" {
  type        = "list"
  description = "the public subnets to launch the UI ELB, must be same order as region_azs"
}

variable "private_subnets" {
  type        = "list"
  description = "the private subnets to launch the master instances into, must be same order as region_azs"
}

variable "cluster_name" {}

variable "coreos_ami" {
  default = ""
}

variable "instance_type" {
  default = "r3.xlarge"
}

variable "key_name" {}

variable "default_security_group" {}

variable "extra_security_groups" {
  type    = "list"
  default = []
}

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

# the exhibitor bucket
variable "exhibitor_bucket" {}

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

variable "idle_timeout" {
  default     = 60
  description = "The number of seconds before timing out idle sockets"
}

variable "ssl_arn" {
  default     = ""
  description = "an SSL arn to have the external ELB expose traffic to"
}

variable "tags" {
  type        = "list"
  default     = []
  description = "a list of maps with properties for tags, see https://www.terraform.io/docs/providers/aws/r/autoscaling_group.html#tags"
}
