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

variable "private_subnets" {
  description = "the subnets to launch the instances into"
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

variable "extra_security_groups" {
  description = "any extra security groups to be applied"
  type        = "list"
  default     = []
}

variable "root_volume_size" {
  description = "the size of the root volume"
  default     = 20
}

variable "max_size" {
  description = "the max number of instances (for master ASGs, this MUST agree with min and desired)"
  default     = 3
}

variable "min_size" {
  description = "the min number of instances (for master ASGs, this MUST agree with max and desired)"
  default     = 3
}

variable "desired_capacity" {
  description = "the base number of instances (for master ASGs, this MUST agree with max and min)"
  default     = 3
}

variable "cloud_config_template" {
  description = "the path to a cloud config, if not defined, uses the default template. See the default template for details and use that as a source for customizations"
  default     = ""
}

variable "work_bucket" {
  description = "the work bucket for temporary objects"
}

variable "work_prefix" {
  description = "the work prefix to use for temporary work objects"
  default     = "work"
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
  default     = "8480"
  description = "from port 80 on the LB, which backend port to hit"
}

variable "https_instance_port" {
  default     = "8443"
  description = "from port 443 on the LB, which backend port to hit"
}

variable "idle_timeout" {
  default     = 60
  description = "The number of seconds before timing out idle sockets"
}

variable "tags" {
  type        = "list"
  default     = []
  description = "a list of maps with properties for tags, see https://www.terraform.io/docs/providers/aws/r/autoscaling_group.html#tags"
}

variable "enable_init_hook" {
  default     = false
  description = "enable a lifecycle to allow for the ASG to properly join the cluster before continuing"
}

variable "override_asg_name" {
  default     = ""
  description = "override the name of the ASG, which is useful for creating stable names to use with lifecycle hooks or other automation"
}

variable "override_launch_hook_name" {
  default     = ""
  description = "override the name of the hook used for initial lifecycle hooks, useful for automating with proper hooks"
}

variable "lifecycle_action_result" {
  default     = "CONTINUE"
  description = "At the conclusion of a lifecycle hook, CONTINUE indicates that your actions were successful, and that the instance into service, whereas ABANDON indicates that your actions were unsuccessful, and that the instance can be terminated."
}
