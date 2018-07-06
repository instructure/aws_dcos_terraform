
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| asg_wait_time | number of seconds to wait for a lifecycle hook for mesos to install | string | `360` | no |
| associate_public_ip_address |  | string | `false` | no |
| bucket_name |  | string | - | yes |
| cloud_config_template | the path to a cloud config, if not defined, uses the default template. Set a custom template by providing the text, see the source template for an example | string | `` | no |
| cluster_name |  | string | - | yes |
| coreos_ami | the AMI to use, defaults to latest coreos ami | string | `` | no |
| dcos_install_path | the s3 path where the DCOS install is located | string | - | yes |
| dcos_role |  | string | - | yes |
| dcos_version |  | string | - | yes |
| default_security_group | the default security group name (contains common settings for all instances) | string | - | yes |
| desired_capacity |  | string | `1` | no |
| enable_init_hook | enable a lifecycle to allow for the ASG to properly join the cluster before continuing | string | `false` | no |
| group_prefix | override the prefix for asg and launch configs in this group, defaults to dcos-<cluster_name>-<dcos-role> | string | `` | no |
| health_check_grace_period |  | string | `600` | no |
| health_check_type |  | string | `EC2` | no |
| iam_role_name |  | string | - | yes |
| instance_type |  | string | `t2.large` | no |
| key_name |  | string | `ops` | no |
| lifecycle_action_result | At the conclusion of a lifecycle hook, CONTINUE indicates that your actions were successful, and that the instance into service, whereas ABANDON indicates that your actions were unsuccessful, and that the instance can be terminated. | string | `CONTINUE` | no |
| load_balancers |  | list | `<list>` | no |
| max_size |  | string | `1` | no |
| min_size |  | string | `1` | no |
| override_asg_name | override the name of the ASG, which is useful for creating stable names to use with lifecycle hooks or other automation | string | `` | no |
| override_launch_hook_name | override the name of the hook used for initial lifecycle hooks, useful for automating with proper hooks | string | `` | no |
| region |  | string | - | yes |
| region_azs | list of the AZs to deploy into | list | `<list>` | no |
| root_volume_size |  | string | `120` | no |
| security_groups |  | list | `<list>` | no |
| spot_price | set a spot price to create a spot ASG | string | `` | no |
| subnets |  | list | `<list>` | no |
| tags | a list of maps with properties for tags, see https://www.terraform.io/docs/providers/aws/r/autoscaling_group.html#tags | list | `<list>` | no |

## Outputs

| Name | Description |
|------|-------------|
| asg |  |
| instance_profile_arn |  |
| launch_config |  |

