# the aws region to deploy in
variable "aws_region" {
  default = "us-east-1"
}

# comma seperated list of the AZs to deploy into
variable "region_azs" {
  default = "a,b,c"
}

# the vpc to launch the ASG in
variable "vpc_id" {}

# the subnets to launch into, comma seperated, must be the same number of elements as region_azs
variable "subnets" {}

# the name of the environment
variable "env_name" {}

# the name of the ASG, should be unique across asgs
variable "name" {}

variable "coreos_ami" {
  default = "ami-6160910c"
}

# the instance to be used
variable "instance_type" {
  default = "r3.xlarge"
}

# the role instance profile that will be used for launching these instances
variable "role_arn" {}

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

# the type of health check to use to ascertain health in the ASG, ELB or EC2
variable "health_check_type" {
  default = "EC2"
}

# the amount of time to allow an instance after launching to become healthy
variable "health_check_grace_period" {
  default = 600
}

# any ELBs to register the instance to
variable "elbs" {
  default = ""
}

# the dcos role to apply, master, slave, slave_public
variable "dcos_role" {}

# the path to a cloud config, if not defined, uses the default template. See the default template for
# details and use that as a source for customizations
variable "cloud_config_template" {
  default = ""
}

# the url to the DCOS package to download
variable "dcos_install_url" {}

# the spot price for the ASG
variable "spot_price" {}
