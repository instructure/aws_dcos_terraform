
## Inputs

| Name | Description | Default | Required |
|------|-------------|:-----:|:-----:|
| aws_region | the aws region to deploy in | `"us-east-1"` | no |
| region_azs | comma seperated list of the AZs to deploy into | `"a,b,c"` | no |
| vpc_id | the vpc to launch the ASG in | - | yes |
| subnets | the subnets to launch into, comma seperated, must be the same number of elements as region_azs | - | yes |
| env_name | the name of the environment, used as prefix in creating ASG name | - | yes |
| name | the name of the ASG, should be unique across asgs | - | yes |
| coreos_ami | the AMI to use, must be a coreos AMI | `"ami-6160910c"` | no |
| instance_type | the instance type to be used | `"r3.xlarge"` | no |
| role_arn | the role instance profile that will be used for launching these instances | - | yes |
| key_name | the name of the IAM ssh key used | - | yes |
| default_security_group | the default security group name (contains common settings for all instances) | - | yes |
| extra_security_groups | any extra security groups to be applied, comma seperated | `""` | no |
| root_volume_size | the size of the root volume | `20` | no |
| max_size | the max number of instances (for master ASGs, this MUST agree with min and desired) | `3` | no |
| min_size | the min number of instances (for master ASGs, this MUST agree with max and desired) | `3` | no |
| desired_capacity | the base number of instances (for master ASGs, this MUST agree with max and min) | `3` | no |
| health_check_type | the type of health check to use to ascertain health in the ASG, ELB or EC2 | `"EC2"` | no |
| health_check_grace_period | the amount of time to allow an instance after launching to become healthy | `600` | no |
| elbs | any ELBS to register the instances to | `""` | no |
| dcos_role | the dcos role to apply, master, slave, slave_public | - | yes |
| cloud_config_template | the path to a cloud config, if not defined, uses the default template. Set a custom template by providing the text, see the source template for an example | `""` | no |
| dcos_install_url | the url to the DCOS package to download | - | yes |
| spot_price | set a spot price to create a spot ASG | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| launch_config |  |
| asg |  |
| sec_group |  |

