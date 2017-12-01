
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| agent_cloud_config_template |  | string | `` | no |
| agent_count |  | string | `5` | no |
| agent_http_instance_port | from port 80 on the LB, which backend port to hit in the agent ASG | string | `8480` | no |
| agent_https_instance_port | from port 443 on the LB, which backend port to hit in the agent ASG | string | `8443` | no |
| agent_idle_timeout | The number of seconds before timing out idle sockets for agent ELB | string | `60` | no |
| agent_instance_type |  | string | `r3.xlarge` | no |
| agent_root_volume_size | root volume size for public agent instances | string | `20` | no |
| bootstrap_build_script_path | path to a custom build script for building and upload a dcos install package | string | `` | no |
| bootstrap_role_arn | an arn to assume when uploading the bootstrap package, if not provided, will use instance creds | string | `` | no |
| bucket | the bucket for exhibitor and bootstrapping | string | - | yes |
| cluster_name | the name of the environment | string | - | yes |
| coreos_ami | the ami to use (must be coreos), defaults to latest coreos | string | `` | no |
| dcos_url | the dcos_generate_config.sh package to use, defaults to https://downloads.dcos.io/dcos/stable/${DCOS_VERSION}/dcos_generate_config.sh | string | `` | no |
| dcos_version | the version of DCOS to install, must be a stable released version (otherwise use dcos_url and arbitrary version here) | string | - | yes |
| extra_agent_sec_groups | a list of extra security groups for private agents | list | `<list>` | no |
| extra_master_internal_sec_groups | a list of extra security groups for internal elb | list | `<list>` | no |
| extra_master_sec_groups | a list of extra security groups for master instances | list | `<list>` | no |
| extra_public_agent_sec_groups | a list of extra security groups for public agents | list | `<list>` | no |
| key_name | the name of the IAM ssh key | string | - | yes |
| master_cloud_config_template |  | string | `` | no |
| master_count |  | string | `3` | no |
| master_idle_timeout | The number of seconds before timing out idle sockets for master ELB | string | `60` | no |
| master_instance_type |  | string | `r3.xlarge` | no |
| master_root_volume_size | root volume size for master instances | string | `20` | no |
| master_ssl_arn | an SSL arn to apply to the master public ELB | string | `` | no |
| max_agent_count |  | string | `8` | no |
| max_public_agent_count |  | string | `4` | no |
| min_agent_count |  | string | `2` | no |
| min_public_agent_count |  | string | `1` | no |
| network | the cidr of your vpc | string | - | yes |
| private_agent_instance_type |  | string | `` | no |
| private_subnets | the private subnets of your VPC | list | - | yes |
| public_agent_cloud_config_template |  | string | `` | no |
| public_agent_count |  | string | `2` | no |
| public_agent_http_instance_port | from port 80 on the LB, which backend port to hit in the public agent ASG | string | `80` | no |
| public_agent_https_instance_port | from port 443 on the LB, which backend port to hit in the public agent ASG | string | `443` | no |
| public_agent_idle_timeout | The number of seconds before timing out idle sockets for public agent ELB | string | `60` | no |
| public_agent_instance_type |  | string | `` | no |
| public_agent_root_volume_size | root volume size for private agent instances | string | `20` | no |
| public_subnets | the public subnets of your VPC | list | - | yes |
| region |  | string | - | yes |
| region_azs | the list of AZs to deploy into | list | `<list>` | no |
| vpc_id |  | string | - | yes |

## Outputs

| Name | Description |
|------|-------------|
| agent_asg |  |
| agent_instance_profile_arn |  |
| agent_launch_config |  |
| agent_lb |  |
| agent_lb_dns |  |
| agent_lb_sec_group |  |
| agent_role_arn |  |
| agent_role_id |  |
| dcos_install_path |  |
| default_security_group |  |
| master_asg |  |
| master_instance_profile_arn |  |
| master_internal_elb |  |
| master_internal_elb_dns |  |
| master_internal_sec_group |  |
| master_launch_config |  |
| master_public_lb |  |
| master_public_lb_dns |  |
| master_public_lb_sec_group |  |
| master_role_arn |  |
| master_role_id |  |
| public_agent_asg |  |
| public_agent_instance_profile_arn |  |
| public_agent_launch_config |  |
| public_agent_lb |  |
| public_agent_lb_dns |  |
| public_agent_lb_sec_group |  |
| public_agent_role_arn |  |
| public_agent_role_id |  |

