variable "cluster_name" {
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
  type        = "list"
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
  default     = []
  type        = "list"
  description = "a list of extra security groups for the ELB"
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

variable "idle_timeout" {
  default     = 60
  description = "The number of seconds before timing out idle sockets"
}

variable "ssl_arn" {
  default     = ""
  description = "an optional SSL arn that will cause the ELB to do SSL termination, changes the https lb port to point to http_instance_port"
}
