variable "region" {}

variable "cluster_name" {
  description = "the name of the environment"
}

variable "vpc_id" {}

variable "network" {
  description = "the cidr of your vpc"
}

variable "private_subnets" {
  type        = "list"
  description = "the private subnets of your VPC"
}

variable "public_subnets" {
  type        = "list"
  description = "the public subnets of your VPC"
}

variable "extra_master_sec_groups" {
  type        = "list"
  default     = []
  description = "a list of extra security groups for master instances"
}

variable "extra_master_internal_sec_groups" {
  type        = "list"
  default     = []
  description = "a list of extra security groups for internal elb"
}

variable "extra_agent_sec_groups" {
  type        = "list"
  default     = []
  description = "a list of extra security groups for private agents"
}

variable "extra_public_agent_sec_groups" {
  type        = "list"
  default     = []
  description = "a list of extra security groups for public agents"
}

variable "region_azs" {
  type        = "list"
  default     = ["a", "b", "c"]
  description = "the list of AZs to deploy into"
}

variable "coreos_ami" {
  description = "the ami to use (must be coreos), defaults to latest coreos"
  default     = ""
}

variable "key_name" {
  description = "the name of the IAM ssh key"
}

variable "bucket" {
  description = "the bucket for exhibitor and bootstrapping"
}

variable "master_root_volume_size" {
  default     = 20
  description = "root volume size for master instances"
}

variable "agent_root_volume_size" {
  description = "root volume size for public agent instances"
  default     = 20
}

variable "public_agent_root_volume_size" {
  description = "root volume size for private agent instances"
  default     = 20
}

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

variable "dcos_version" {
  description = "the version of DCOS to install, must be a stable released version (otherwise use dcos_url and arbitrary version here)"
}

variable "dcos_url" {
  description = "the dcos_generate_config.sh package to use, defaults to https://downloads.dcos.io/dcos/stable/${DCOS_VERSION}/dcos_generate_config.sh"
  default     = ""
}

variable "bootstrap_role_arn" {
  description = "an arn to assume when uploading the bootstrap package, if not provided, will use instance creds"
  default     = ""
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

variable "master_ssl_arn" {
  default     = ""
  description = "an SSL arn to apply to the master public ELB"
}

variable "common_tags" {
  type        = "list"
  default     = []
  description = "a list of maps with properties for tags in all DC/OS ASGs, see https://www.terraform.io/docs/providers/aws/r/autoscaling_group.html#tags"
}

variable "master_tags" {
  type        = "list"
  default     = []
  description = "a list of maps with properties for tags in master ASG, see https://www.terraform.io/docs/providers/aws/r/autoscaling_group.html#tags"
}

variable "agent_tags" {
  type        = "list"
  default     = []
  description = "a list of maps with properties for tags in agent ASG, see https://www.terraform.io/docs/providers/aws/r/autoscaling_group.html#tags"
}

variable "public_agent_tags" {
  type        = "list"
  default     = []
  description = "a list of maps with properties for tags in public_agent ASG, see https://www.terraform.io/docs/providers/aws/r/autoscaling_group.html#tags"
}
