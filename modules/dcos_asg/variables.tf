variable "aws_region" {
  default     = "us-east-1"
  description = "the aws region to deploy in"
}

variable "region_azs" {
  default     = "a,b,c"
  description = "comma seperated list of the AZs to deploy into"
}

variable "vpc_id" {
  description = "the vpc to launch the ASG in"
}

variable "subnets" {
  description = "the subnets to launch into, comma seperated, must be the same number of elements as region_azs"
}

variable "env_name" {
  description = "the name of the environment, used as prefix in creating ASG name"
}

variable "name" {
  description = "the name of the ASG, should be unique across asgs"
}

variable "coreos_ami" {
  default     = "ami-6160910c"
  description = "the AMI to use, must be a coreos AMI"
}

variable "instance_type" {
  default     = "r3.xlarge"
  description = "the instance type to be used"
}

variable "role_arn" {
  description = "the role instance profile that will be used for launching these instances"
}

variable "key_name" {
  description = "the name of the IAM ssh key used"
}

variable "default_security_group" {
  description = "the default security group name (contains common settings for all instances)"
}

variable "extra_security_groups" {
  description = "any extra security groups to be applied, comma seperated"
  default     = ""
}

variable "root_volume_size" {
  default     = 20
  description = "the size of the root volume"
}

variable "max_size" {
  default     = 3
  description = "the max number of instances (for master ASGs, this MUST agree with min and desired)"
}

variable "min_size" {
  default     = 3
  description = "the min number of instances (for master ASGs, this MUST agree with max and desired)"
}

variable "desired_capacity" {
  default     = 3
  description = "the base number of instances (for master ASGs, this MUST agree with max and min)"
}

variable "health_check_type" {
  default     = "EC2"
  description = "the type of health check to use to ascertain health in the ASG, ELB or EC2"
}

variable "health_check_grace_period" {
  default     = 600
  description = "the amount of time to allow an instance after launching to become healthy"
}

variable "elbs" {
  default     = ""
  description = "any ELBS to register the instances to"
}

variable "dcos_role" {
  description = "the dcos role to apply, master, slave, slave_public"
}

variable "cloud_config_template" {
  default     = ""
  description = "the path to a cloud config, if not defined, uses the default template. Set a custom template by providing the text, see the source template for an example"
}

variable "dcos_install_url" {
  description = "the url to the DCOS package to download"
}

variable "spot_price" {
  default     = ""
  description = "set a spot price to create a spot ASG"
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
