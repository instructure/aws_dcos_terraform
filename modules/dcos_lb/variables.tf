variable "env_name" {
  description = "the name of the environment"
}

variable "name" {
  description = "the name of the lb such a public_agent, etc"
}

variable "vpc_id" {
  description = "the id of the vpc"
}

variable "network" {
  description = "the cidr of your vpc"
}

variable "subnets" {
  description = "the subnets to launch the ELB into, this determines whether public or private"
}

variable "internal_lb" {
  default     = true
  description = "true to create an internal lb, false if you want to publicly expose it"
}

variable "default_security_group" {
  description = "the security group that all dcos components share"
}

variable "extra_security_groups" {
  default     = ""
  description = "a comma seperated list of extra security groups for the ELB"
}

variable "health_check_path" {
  default     = "HTTP:9090/_haproxy_health_check"
  description = "the healthcheck URL to use"
}

variable "http_instance_port" {
  default     = "80"
  description = "from port 80 on the LB, which backend port to hit"
}

variable "https_instance_port" {
  default     = "443"
  description = "from port 443 on the LB, which backend port to hit"
}

variable "cross_zone_load_balancing" {
  default     = true
  description = "enable cross zone load balancing"
}
