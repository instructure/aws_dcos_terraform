
## Inputs

| Name | Description | Default | Required |
|------|-------------|:-----:|:-----:|
| aws_region |  | - | yes |
| env_name |  | - | yes |
| vpc_id |  | - | yes |
| network |  | - | yes |
| private_subnets |  | - | yes |
| public_subnets |  | - | yes |
| extra_master_sec_groups |  | `""` | no |
| extra_master_internal_sec_groups |  | `""` | no |
| extra_agent_sec_groups |  | `""` | no |
| extra_public_agent_sec_groups |  | `""` | no |
| region_azs |  | `"a,b,c"` | no |
| coreos_ami |  | `"ami-6160910c"` | no |
| key_name |  | - | yes |
| exhibitor_bucket |  | - | yes |
| bootstrap_bucket |  | - | yes |
| master_root_volume_size |  | `20` | no |
| agent_root_volume_size |  | `20` | no |
| public_agent_root_volume_size |  | `20` | no |
| master_count |  | `3` | no |
| master_instance_type |  | `"r3.xlarge"` | no |
| agent_instance_type |  | `"r3.xlarge"` | no |
| public_agent_instance_type |  | `""` | no |
| private_agent_instance_type |  | `""` | no |
| max_agent_count |  | `8` | no |
| min_agent_count |  | `2` | no |
| agent_count |  | `5` | no |
| max_public_agent_count |  | `4` | no |
| min_public_agent_count |  | `1` | no |
| public_agent_count |  | `2` | no |
| master_cloud_config_template |  | `""` | no |
| agent_cloud_config_template |  | `""` | no |
| public_agent_cloud_config_template |  | `""` | no |
| bootstrap_build_script_path | path to a custom build script for building and upload a dcos install package | `""` | no |
| agent_http_instance_port | from port 80 on the LB, which backend port to hit in the agent ASG | `"8480"` | no |
| agent_https_instance_port | from port 443 on the LB, which backend port to hit in the agent ASG | `"8443"` | no |
| public_agent_http_instance_port | from port 80 on the LB, which backend port to hit in the public agent ASG | `"80"` | no |
| public_agent_https_instance_port | from port 443 on the LB, which backend port to hit in the public agent ASG | `"443"` | no |

## Outputs

| Name | Description |
|------|-------------|
| default_security_group |  |
| master_internal_elb_dns |  |
| master_internal_elb |  |
| master_internal_sec_group |  |
| dcos_install_url |  |
| master_launch_config |  |
| master_asg |  |
| master_asg_sec_group |  |
| master_role_arn |  |
| master_role_id |  |
| master_public_lb_dns |  |
| master_public_lb |  |
| master_public_lb_sec_group |  |
| agent_launch_config |  |
| agent_asg |  |
| agent_asg_sec_group |  |
| agent_role_arn |  |
| agent_role_id |  |
| agent_lb_dns |  |
| agent_lb |  |
| agent_lb_sec_group |  |
| public_agent_launch_config |  |
| public_agent_asg |  |
| public_agent_asg_sec_group |  |
| public_agent_role_arn |  |
| public_agent_role_id |  |
| public_agent_lb_dns |  |
| public_agent_lb |  |
| public_agent_lb_sec_group |  |

