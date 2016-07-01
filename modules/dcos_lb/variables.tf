# the name of the environment
variable "env_name" {}
# the name of the lb such a public_agent, etc
variable "name" {}
# the id of the vpc
variable "vpc_id" {}
# the cidr of your vpc
variable "network" {}
# the subnets to launch the ELB into, this determines whether public or private
variable "subnets" {}
# true to create an internal lb, false if you want to publicly expose it
variable "internal_lb" {
  default = true
}
# the security group that all dcos components share
variable "default_security_group" {}
# a comma seperated list of extra security groups for the ELB
variable "extra_security_groups" {
  default = ""
}
# the healthcheck URL to use {
variable "health_check_path" {
  default = "HTTP:9090/_haproxy_health_check"
}
