variable "region" {}
variable "cluster_name" {}
variable "dcos_role" {}
variable "dcos_version" {}

variable "dcos_install_path" {
  description = "the s3 path where the DCOS install is located"
}

variable "bucket_name" {}

variable "group_prefix" {
  description = "override the prefix for asg and launch configs in this group, defaults to dcos-<cluster_name>-<dcos-role>"
  default     = ""
}

variable "tags" {
  type        = "list"
  default     = []
  description = "a list of maps with properties for tags, see https://www.terraform.io/docs/providers/aws/r/autoscaling_group.html#tags"
}

variable "region_azs" {
  type        = "list"
  default     = ["a", "b", "c"]
  description = "list of the AZs to deploy into"
}

variable "root_volume_size" {
  default = 120
}

variable "coreos_ami" {
  default     = ""
  description = "the AMI to use, defaults to latest coreos ami"
}

variable "instance_type" {
  default = "t2.large"
}

variable "key_name" {
  default = "ops"
}

variable "default_security_group" {
  description = "the default security group name (contains common settings for all instances)"
}

variable "subnets" {
  type    = "list"
  default = []
}

variable "iam_role_name" {}

variable "load_balancers" {
  type    = "list"
  default = []
}

variable "security_groups" {
  type    = "list"
  default = []
}

variable "health_check_type" {
  default = "EC2"
}

variable "health_check_grace_period" {
  default = 600
}

variable "min_size" {
  default = 1
}

variable "max_size" {
  default = 1
}

variable "desired_capacity" {
  default = 1
}

variable "associate_public_ip_address" {
  default = false
}

variable "cloud_config_template" {
  default     = ""
  description = "the path to a cloud config, if not defined, uses the default template. Set a custom template by providing the text, see the source template for an example"
}

variable "spot_price" {
  default     = ""
  description = "set a spot price to create a spot ASG"
}

variable "enable_init_hook" {
  default     = false
  description = "enable a lifecycle to allow for the ASG to properly join the cluster before continuing"
}

variable "asg_wait_time" {
  default     = 360
  description = "number of seconds to wait for a lifecycle hook for mesos to install"
}

variable "override_asg_name" {
  default     = ""
  description = "override the name of the ASG, which is useful for creating stable names to use with lifecycle hooks or other automation"
}

variable "override_launch_hook_name" {
  default     = ""
  description = "override the name of the hook used for initial lifecycle hooks, useful for automating with proper hooks"
}
