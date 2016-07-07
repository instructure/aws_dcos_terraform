
## Inputs

| Name | Description | Default | Required |
|------|-------------|:-----:|:-----:|
| env_name | the name of the environment | - | yes |
| name | the name of the lb such a public_agent, etc | - | yes |
| vpc_id | the id of the vpc | - | yes |
| network | the cidr of your vpc | - | yes |
| subnets | the subnets to launch the ELB into, this determines whether public or private | - | yes |
| internal_lb | true to create an internal lb, false if you want to publicly expose it | `true` | no |
| default_security_group | the security group that all dcos components share | - | yes |
| extra_security_groups | a comma seperated list of extra security groups for the ELB | `""` | no |
| health_check_path | the healthcheck URL to use | `"HTTP:9090/_haproxy_health_check"` | no |
| http_instance_port | from port 80 on the LB, which backend port to hit | `"80"` | no |
| https_instance_port | from port 443 on the LB, which backend port to hit | `"443"` | no |
| cross_zone_load_balancing | enable cross zone load balancing | `true` | no |

## Outputs

| Name | Description |
|------|-------------|
| elb_dns |  |
| elb |  |
| sec_group |  |

