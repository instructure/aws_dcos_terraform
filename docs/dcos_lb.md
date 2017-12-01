
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| cluster_name | the name of the environment | string | - | yes |
| cross_zone_load_balancing | enable cross zone load balancing | string | `true` | no |
| default_security_group | the security group that all dcos components share | string | - | yes |
| extra_security_groups | a list of extra security groups for the ELB | list | `<list>` | no |
| health_check_path | the healthcheck URL to use | string | `HTTP:9090/_haproxy_health_check` | no |
| http_instance_port | from port 80 on the LB, which backend port to hit | string | `80` | no |
| https_instance_port | from port 443 on the LB, which backend port to hit | string | `443` | no |
| idle_timeout | The number of seconds before timing out idle sockets | string | `60` | no |
| internal_lb | true to create an internal lb, false if you want to publicly expose it | string | `true` | no |
| name | the name of the lb such a public_agent, etc | string | - | yes |
| network | the cidr of your vpc | string | - | yes |
| ssl_arn | an optional SSL arn that will cause the ELB to do SSL termination, changes the https lb port to point to http_instance_port | string | `` | no |
| subnets | the subnets to launch the ELB into, this determines whether public or private | list | - | yes |
| vpc_id | the id of the vpc | string | - | yes |

## Outputs

| Name | Description |
|------|-------------|
| elb |  |
| elb_dns |  |
| sec_group |  |

