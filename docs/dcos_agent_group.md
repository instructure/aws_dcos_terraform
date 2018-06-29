
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
| extra_security_groups | any extra security groups to be applied | list | `<list>` | no |
| http_instance_port | from port 80 on the LB, which backend port to hit | string | `8480` | no |
| https_instance_port | from port 443 on the LB, which backend port to hit | string | `8443` | no |
| idle_timeout | The number of seconds before timing out idle sockets | string | `60` | no |
| instance_type | the instance to be used | string | `r3.xlarge` | no |
| key_name | the name of the IAM ssh key used | string | - | yes |
| max_size | the max number of instances (for master ASGs, this MUST agree with min and desired) | string | `3` | no |
| min_size | the min number of instances (for master ASGs, this MUST agree with max and desired) | string | `3` | no |
| network | the cidr of your vpc | string | - | yes |
| private_subnets | the subnets to launch the instances into | list | - | yes |
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

