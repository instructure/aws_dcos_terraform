
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| bucket_name | the primary bucket for bootstrap | string | - | yes |
| cloud_config_template | the path to a cloud config, if not defined, uses the default template. See the default template for details and use that as a source for customizations | string | `` | no |
| cluster_name | the name of the environment | string | - | yes |
| coreos_ami | the ami to use (must be coreos), defaults to latest core-os image | string | `` | no |
| dcos_install_path | the s3 path where the DCOS install is located | string | - | yes |
| dcos_version | the version of dcos | string | - | yes |
| default_security_group | the default security group name (contains common settings for all instances) | string | - | yes |
| desired_capacity | the base number of instances (for master ASGs, this MUST agree with max and min) | string | `3` | no |
| elb_subnets | the subnets to launch the public ELB into | list | - | yes |
| enable_init_hook | enable a lifecycle to allow for the ASG to properly join the cluster before continuing | string | `false` | no |
| extra_security_groups | any extra security groups to be applied | list | `<list>` | no |
| http_instance_port | from port 80 on the LB, which backend port to hit | string | `80` | no |
| https_instance_port | from port 443 on the LB, which backend port to hit | string | `443` | no |
| idle_timeout | The number of seconds before timing out idle sockets | string | `60` | no |
| instance_subnets | the subnets to launch the public agent instances into | list | - | yes |
| instance_type | the instance to be used | string | `r3.xlarge` | no |
| internal_lb | if you want the the lb associated to not actually be public... set this | string | `false` | no |
| key_name | the name of the IAM ssh key used | string | - | yes |
| lifecycle_action_result | At the conclusion of a lifecycle hook, CONTINUE indicates that your actions were successful, and that the instance into service, whereas ABANDON indicates that your actions were unsuccessful, and that the instance can be terminated. | string | `CONTINUE` | no |
| max_size | the max number of instances (for master ASGs, this MUST agree with min and desired) | string | `3` | no |
| min_size | the min number of instances (for master ASGs, this MUST agree with max and desired) | string | `3` | no |
| network | the cidr of your vpc | string | - | yes |
| override_asg_name | override the name of the ASG, which is useful for creating stable names to use with lifecycle hooks or other automation | string | `` | no |
| override_launch_hook_name | override the name of the hook used for initial lifecycle hooks, useful for automating with proper hooks | string | `` | no |
| region | the aws region to deploy in | string | `us-east-1` | no |
| region_azs | lsit of AZs to deploy into | list | `<list>` | no |
| root_volume_size | the size of the root volume | string | `20` | no |
| tags | a list of maps with properties for tags, see https://www.terraform.io/docs/providers/aws/r/autoscaling_group.html#tags | list | `<list>` | no |
| vpc_id |  | string | - | yes |
| work_bucket | the work bucket for temporary objects | string | - | yes |
| work_prefix | the work prefix to use for temporary work objects | string | `work` | no |

## Outputs

| Name | Description |
|------|-------------|
| asg |  |
| instance_profile_arn |  |
| launch_config |  |
| lb |  |
| lb_dns |  |
| lb_sec_group |  |
| role_arn |  |
| role_id |  |

