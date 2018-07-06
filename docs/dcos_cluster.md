
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| agent_cloud_config_template |  | string | `` | no |
| agent_count |  | string | `5` | no |
| agent_enable_init_hook | enable a lifecycle to allow for the ASG to properly join the cluster before continuing | string | `false` | no |
| agent_http_instance_port | from port 80 on the LB, which backend port to hit in the agent ASG | string | `8480` | no |
| agent_https_instance_port | from port 443 on the LB, which backend port to hit in the agent ASG | string | `8443` | no |
| agent_idle_timeout | The number of seconds before timing out idle sockets for agent ELB | string | `60` | no |
| agent_instance_type |  | string | `r3.xlarge` | no |
| agent_lifecycle_action_result | At the conclusion of a lifecycle hook, CONTINUE indicates that your actions were successful, and that the instance into service, whereas ABANDON indicates that your actions were unsuccessful, and that the instance can be terminated. | string | `CONTINUE` | no |
| agent_override_asg_name | override the name of the agent ASG, which is useful for creating stable names to use with lifecycle hooks or other automation | string | `` | no |
| agent_override_launch_hook_name | override the agent name of the hook used for initial lifecycle hooks, useful for automating with proper hooks | string | `` | no |
| agent_root_volume_size | root volume size for public agent instances | string | `20` | no |
| agent_tags | a list of maps with properties for tags in agent ASG, see https://www.terraform.io/docs/providers/aws/r/autoscaling_group.html#tags | list | `<list>` | no |
| bootstrap_build_script_path | path to a custom build script for building and upload a dcos install package | string | `` | no |
| bootstrap_role_arn | an arn to assume when uploading the bootstrap package, if not provided, will use instance creds | string | `` | no |
| bucket | the bucket for exhibitor and bootstrapping | string | - | yes |
| cluster_name | the name of the environment | string | - | yes |
| common_tags | a list of maps with properties for tags in all DC/OS ASGs, see https://www.terraform.io/docs/providers/aws/r/autoscaling_group.html#tags | list | `<list>` | no |
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
| master_enable_init_hook | enable a lifecycle to allow for the ASG to properly join the cluster before continuing | string | `false` | no |
| master_idle_timeout | The number of seconds before timing out idle sockets for master ELB | string | `60` | no |
| master_instance_type |  | string | `r3.xlarge` | no |
| master_lifecycle_action_result | At the conclusion of a lifecycle hook, CONTINUE indicates that your actions were successful, and that the instance into service, whereas ABANDON indicates that your actions were unsuccessful, and that the instance can be terminated. | string | `CONTINUE` | no |
| master_override_asg_name | override the name of the master ASG, which is useful for creating stable names to use with lifecycle hooks or other automation | string | `` | no |
| master_override_launch_hook_name | override the master name of the hook used for initial lifecycle hooks, useful for automating with proper hooks | string | `` | no |
| master_root_volume_size | root volume size for master instances | string | `20` | no |
| master_ssl_arn | an SSL arn to apply to the master public ELB | string | `` | no |
| master_tags | a list of maps with properties for tags in master ASG, see https://www.terraform.io/docs/providers/aws/r/autoscaling_group.html#tags | list | `<list>` | no |
| max_agent_count |  | string | `8` | no |
| max_public_agent_count |  | string | `4` | no |
| min_agent_count |  | string | `2` | no |
| min_public_agent_count |  | string | `1` | no |
| network | the cidr of your vpc | string | - | yes |
| private_agent_instance_type |  | string | `` | no |
| private_subnets | the private subnets of your VPC | list | - | yes |
| public_agent_cloud_config_template |  | string | `` | no |
| public_agent_count |  | string | `2` | no |
| public_agent_enable_init_hook | enable a lifecycle to allow for the ASG to properly join the cluster before continuing | string | `false` | no |
| public_agent_http_instance_port | from port 80 on the LB, which backend port to hit in the public agent ASG | string | `80` | no |
| public_agent_https_instance_port | from port 443 on the LB, which backend port to hit in the public agent ASG | string | `443` | no |
| public_agent_idle_timeout | The number of seconds before timing out idle sockets for public agent ELB | string | `60` | no |
| public_agent_instance_type |  | string | `` | no |
| public_agent_lifecycle_action_result | At the conclusion of a lifecycle hook, CONTINUE indicates that your actions were successful, and that the instance into service, whereas ABANDON indicates that your actions were unsuccessful, and that the instance can be terminated. | string | `CONTINUE` | no |
| public_agent_override_asg_name | override the name of the public_agent ASG, which is useful for creating stable names to use with lifecycle hooks or other automation | string | `` | no |
| public_agent_override_launch_hook_name | override the public_agent name of the hook used for initial lifecycle hooks, useful for automating with proper hooks | string | `` | no |
| public_agent_root_volume_size | root volume size for private agent instances | string | `20` | no |
| public_agent_tags | a list of maps with properties for tags in public_agent ASG, see https://www.terraform.io/docs/providers/aws/r/autoscaling_group.html#tags | list | `<list>` | no |
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

