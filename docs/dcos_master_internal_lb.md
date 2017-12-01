
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| cluster_name | the name of the environment | string | - | yes |
| default_security_group | the security group that all dcos components share | string | - | yes |
| extra_security_groups | a comma seperated list of extra security groups for the ELB | list | `<list>` | no |
| network | the cidr of your vpc | string | - | yes |
| private_subnets | the subnets to launch the ELB into (should be private subnets!) | list | - | yes |
| vpc_id | the id of the vpc | string | - | yes |

## Outputs

| Name | Description |
|------|-------------|
| elb |  |
| elb_dns |  |
| sec_group |  |

