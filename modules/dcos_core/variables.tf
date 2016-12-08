# the aws region
variable "aws_region" {}

# the name of the environment
variable "env_name" {}

# the id of the vpc
variable "vpc_id" {}

# the cidr of your vpc
variable "network" {}

# the private subnets of your vpc
variable "private_subnets" {}

# the public subnets of your vpc
variable "public_subnets" {}

# a comma seperated list of extra security groups for master instances
variable "extra_master_sec_groups" {
  default = ""
}

# a comma seperated list of extra security groups for internal elb
variable "extra_master_internal_sec_groups" {
  default = ""
}

# a comma seperated list of extra security groups for agent
variable "extra_agent_sec_groups" {
  default = ""
}

# a comma seperated list of extra security groups for public agents
variable "extra_public_agent_sec_groups" {
  default = ""
}

# comma seperated list of the AZs to deploy into
variable "region_azs" {
  default = "a,b,c"
}

# the ami to use (must be coreos)
variable "coreos_ami" {
  default = "ami-6160910c"
}

# the name of the IAM ssh key used
variable "key_name" {}

# the exhibitor bucket
variable "exhibitor_bucket" {}

# the bootstrap bucket
variable "bootstrap_bucket" {}

# the root volume size for master
variable "master_root_volume_size" {
  default = 20
}

# the root volume size for master
variable "agent_root_volume_size" {
  default = 20
}

variable "public_agent_root_volume_size" {
  default = 20
}

# the number of masters
variable "master_count" {
  default = 3
}

variable "master_instance_type" {
  default = "r3.xlarge"
}

variable "agent_instance_type" {
  default = "r3.xlarge"
}

variable "public_agent_instance_type" {
  default = ""
}

variable "private_agent_instance_type" {
  default = ""
}

variable "max_agent_count" {
  default = 8
}

variable "min_agent_count" {
  default = 2
}

variable "agent_count" {
  default = 5
}

variable "max_public_agent_count" {
  default = 4
}

variable "min_public_agent_count" {
  default = 1
}

variable "public_agent_count" {
  default = 2
}

variable "master_cloud_config_template" {
  default = ""
}

variable "agent_cloud_config_template" {
  default = ""
}

variable "public_agent_cloud_config_template" {
  default = ""
}

variable "dcos_url" {
  description = "the dcos_generate_config.sh package to use, defaults to https://downloads.dcos.io/dcos/stable/dcos_generate_config.sh, which will be latest dcos version"
  default     = "https://downloads.dcos.io/dcos/stable/dcos_generate_config.sh"
}

variable "cluster_version" {
  description = "A version number of your cluster, bump this if you want to force an upgrade"
  default     = "1"
}

variable "bootstrap_build_script_path" {
  default     = ""
  description = "path to a custom build script for building and upload a dcos install package"
}

variable "agent_http_instance_port" {
  default     = "8480"
  description = "from port 80 on the LB, which backend port to hit in the agent ASG"
}

variable "agent_https_instance_port" {
  default     = "8443"
  description = "from port 443 on the LB, which backend port to hit in the agent ASG"
}

variable "public_agent_http_instance_port" {
  default     = "80"
  description = "from port 80 on the LB, which backend port to hit in the public agent ASG"
}

variable "public_agent_https_instance_port" {
  default     = "443"
  description = "from port 443 on the LB, which backend port to hit in the public agent ASG"
}

variable "master_idle_timeout" {
  default     = 60
  description = "The number of seconds before timing out idle sockets for master ELB"
}

variable "agent_idle_timeout" {
  default     = 60
  description = "The number of seconds before timing out idle sockets for agent ELB"
}

variable "public_agent_idle_timeout" {
  default     = 60
  description = "The number of seconds before timing out idle sockets for public agent ELB"
}
