
## Inputs

| Name | Description | Default | Required |
|------|-------------|:-----:|:-----:|
| aws_region |  | `"us-east-1"` | no |
| region_azs |  | `"a,b,c"` | no |
| vpc_id |  | - | yes |
| subnets |  | - | yes |
| env_name |  | - | yes |
| name |  | - | yes |
| coreos_ami |  | `"ami-6160910c"` | no |
| instance_type |  | `"r3.xlarge"` | no |
| role_arn |  | - | yes |
| key_name |  | - | yes |
| default_security_group |  | - | yes |
| extra_security_groups |  | - | yes |
| root_volume_size |  | `20` | no |
| max_size |  | `3` | no |
| min_size |  | `3` | no |
| desired_capacity |  | `3` | no |
| health_check_type |  | `"EC2"` | no |
| health_check_grace_period |  | `600` | no |
| elbs |  | `""` | no |
| dcos_role |  | - | yes |
| cloud_config_template |  | `""` | no |
| dcos_install_url |  | - | yes |
| spot_price |  | - | yes |

## Outputs

| Name | Description |
|------|-------------|
| launch_config |  |
| asg |  |
| sec_group |  |

