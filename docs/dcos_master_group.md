
## Inputs

| Name | Description | Default | Required |
|------|-------------|:-----:|:-----:|
| aws_region |  | `"us-east-1"` | no |
| region_azs |  | `"a,b,c"` | no |
| network |  | - | yes |
| vpc_id |  | - | yes |
| public_subnets |  | - | yes |
| private_subnets |  | - | yes |
| env_name |  | - | yes |
| coreos_ami |  | `"ami-6160910c"` | no |
| instance_type |  | `"r3.xlarge"` | no |
| key_name |  | - | yes |
| default_security_group |  | - | yes |
| extra_security_groups |  | - | yes |
| root_volume_size |  | `20` | no |
| max_size |  | `3` | no |
| min_size |  | `3` | no |
| desired_capacity |  | `3` | no |
| master_internal_lb |  | - | yes |
| cloud_config_template |  | `""` | no |
| dcos_install_url |  | - | yes |
| exhibitor_bucket |  | - | yes |
| work_bucket |  | - | yes |
| work_prefix |  | `"work"` | no |

## Outputs

| Name | Description |
|------|-------------|
| launch_config |  |
| asg |  |
| asg_sec_group |  |
| role_arn |  |
| role_id |  |
| instance_profile_arn |  |
| public_lb_dns |  |
| public_lb |  |
| public_lb_sec_group |  |

