# the name of the environment
variable "env_name" {}

# the id of the vpc
variable "vpc_id" {}

# the cidr of your vpc
variable "network" {}

# the subnets to launch the ELB into (should be private subnets!)
variable "private_subnets" {}

# the security group that all dcos components share
variable "default_security_group" {}

# a comma seperated list of extra security groups for the ELB
variable "extra_security_groups" {
  default = ""
}
