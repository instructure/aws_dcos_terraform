
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| bucket_name | the primary bucket for bootstrap | string | - | yes |
| cloud_config_template | the path to a cloud config, if not defined, uses the default template. See the default template for details and use that as a source for customizations | string | `` | no |
| cluster_name |  | string | - | yes |
| coreos_ami |  | string | `` | no |
| dcos_install_path | the s3 path where the DCOS install is located | string | - | yes |
| dcos_version | the version of dcos | string | - | yes |
| default_security_group |  | string | - | yes |
| desired_capacity | the base number of instances (for master ASGs, this MUST agree with max and min) | string | `3` | no |
| exhibitor_bucket | the exhibitor bucket | string | - | yes |
| extra_security_groups |  | list | `<list>` | no |
| idle_timeout | The number of seconds before timing out idle sockets | string | `60` | no |
| instance_type |  | string | `r3.xlarge` | no |
| key_name |  | string | - | yes |
| master_internal_lb | The id of the internal lb | string | - | yes |
| max_size | the max number of instances (for master ASGs, this MUST agree with min and desired) | string | `3` | no |
| min_size | the min number of instances (for master ASGs, this MUST agree with max and desired) | string | `3` | no |
| network | cidr of your VPC | string | - | yes |
| private_subnets | the private subnets to launch the master instances into, must be same order as region_azs | list | - | yes |
| public_subnets | the public subnets to launch the UI ELB, must be same order as region_azs | list | - | yes |
| region |  | string | `us-east-1` | no |
| region_azs | lits of AZs to deploy into | list | `<list>` | no |
| root_volume_size |  | string | `20` | no |
| ssl_arn | an SSL arn to have the external ELB expose traffic to | string | `` | no |
| vpc_id |  | string | - | yes |
| work_bucket | the work bucket for temporary objects | string | - | yes |
| work_prefix | the work prefix to use for temporary work objects | string | `work` | no |

## Outputs

| Name | Description |
|------|-------------|
| asg |  |
| instance_profile_arn |  |
| launch_config |  |
| public_lb |  |
| public_lb_dns |  |
| public_lb_sec_group |  |
| role_arn |  |
| role_id |  |

