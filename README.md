Terraform Modules for DC/OS on AWS
===============

An (almost) produciton ready set of modules for provisioning DC/OS in AWS.

These modules implement the advanced installer (https://dcos.io/docs/1.7/administration/installing/custom/advanced/)
and using some clever terraform tricks, are able to do it in a single `terraform apply`

### What it does:
- Builds the prerequisite resources to get a s3 bucket for exhibitor and internal ELB for master discovery
- Creates an S3 VPC endpoint that replaces the need for a bootstrap server
- Passes those resources into a script that builds and uploads a DC/OS package via docker and waits for it to finish
- Provisions ASGs and ELBs for masters, slaves, etc
- Creates ECR repos and lambda function for writing docker credentials for private images
- Gives you extension points for customizing as you see fit

### What is missing here (and hope to get added):
- Modules for creating initial VPC
- CloudWatch alerts for monitoring

### What else you will need to add:
Their are some decisions I don't want to make for you, but this intended to be flexible enough to extend to fit
your needs, but will probably want to consider:
- Log aggregation for DC/OS components
- Host level metric collection


# Getting Started

### Prereqs:
- Be famaliar with terraform
- have docker installed with proper volumes support (see `Docker Notes` below)
- have a VPC provisioned you want to deploy in

### Create the terraform
The example belows gives a complete example of creating a DC/OS cluster using the default setup of:
- 3 masters in private subnets, with an external admin ELB and an internal discovery ELB
- 5 agents in private subnets, with an internal ELB for exposing VPC only apps
- 2 public agents in private subnets, with an external ELB for publicly exposing apps

It also creates an ECR repo with a lambda function that drops credentials into a bucket
for consumption by marathon for pulling private images

```
variable "vpc_id" {
  default = "vpc-xxxxxxx"
  description = "the vpc you want to provision into"
}
variable "route_table_ids" {
  default = "rtb-xxxxxx1,rtb-xxxxxx2"
  description = "comma seperated list of route tables"
}
variable "env_name" {
  default = "test_env"
  description = "the name of the environment, allows for multiple DC/OS clusters in a VPC"
}
variable "network" {
  default = "10.0.0.0/16"
  description = "the cidr of your VPC"
}
variable "public_subnets" {
  default = "subnet-xxxxxx1,subnet-xxxxxx2"
  description = "a comma seperated list of public subnets in your VPC"
}
variable "private_subnets" {
  default = "subnet-xxxxxx1,subnet-xxxxxx2"
  description = "a comma seperated list of private subnets in your VPC"
}
variable "key_name" {
  default = "my_key"
  description = "the ssh key name you want to use in provision hosts"
}
variable "region_azs" {
  default = "a,b"
  description = "the availiability zones corresponding to your subnets"
}
provider "aws" {
  region = "${var.aws_region}"
}

module  "dcos_region" {
  source = "github.com/instructure/aws_dcos_terraform//modules/dcos_region"
  vpc_id = "${var.vpc_id}"
  aws_region = "${var.aws_region}"
  route_table_ids = "${var.route_table_ids}"
}

module "dcos_core" {
  source = "github.com/instructure/aws_dcos_terraform//modules/dcos_core"
  env_name = "${var.env_name}"
  vpc_id = "${var.vpc_id}"
  aws_region = "${var.aws_region}"
  network = "${var.network}" # cidr of VPC
  public_subnets = "${var.public_subnets}"
  private_subnets = "${var.private_subnets}"
  bootstrap_bucket = "${module.dcos_region.bootstrap_bucket}"
  exhibitor_bucket = "${module.dcos_region.exhibitor_bucket}"
  key_name = "${var.key_name}"
  region_azs = "${var.region_azs}"
}


variable "namespace" {
  default = "my_group"
  description = "the namespace you want to create repos under"
}
variable "repo_names" {
  default = "my_app1,myapp_2"
  description = "a comma seperated list of ECR repos you want to create"
}
variable "account_id" {
  default = "1234567890"
  description = "your aws account id"
}
variable "allowed_users" {
  default = "bob,lisa,mark"
  description = "comma seperated list of IAM users who should be able to push to the given repos"
}
module "ecr" {
  source = "github.com/instructure/aws_dcos_terraform//modules/ecr"
  env_name = "${var.env_name}"
  # we reuse this bucket for also storing docker creds
  docker_cred_bucket = "${module.dcos_region.bootstrap_bucket}"
  namespace = "${var.namespace}"
  repo_names = "${var.repo_names}"
  account_id = "${var.account_id}"
  users = "${var.allowed_users}"
}
```

### Build it
`terraform plan` and `terraform apply` should bring you up a full DC/OS cluster

# Advanced Usage

The modules are highly modularlized, allowing for a customization. If you don't want public agents, you don't
have to have them. See the `modules` folder for the individual modules. Additionally, you may want to
use different user_data for setting up nodes, such as adding users or running your own config management. To faciliate
that, any resources that use templates or provisioner scripts take paths that allow for injecting custom functionality.

### Module Details

Here are descriptions of each module, mix and match as you please to build your customized cluster

- `dcos_agent_group`, creates a role, ELB, and ASG of private agents, used in `dcos_core`, just combines other modules
- `dcos_agent_role`, the IAM role that agents use by default
- `dcos_asg`, an ASG and launch configuration that are used for all DC/OS roles
- `dcos_bootstrap`, the module that creates a DC/OS bootstrap package
- `dcos_core`, the 'default' DC/OS setup, which is simply composed of other modules
- `dcos_lb`, an ELB for association with an ASG
- `dcos_master_group`, creates a role, public ELB, and ASG for masters, used in `dcos_core`, just combines other modules
- `dcos_master_internal_lb`, creates the internal elb, required for `master_discovery: master_http_loadbalancer`
- `dcos_master_role`, the IAM role that masters use by default
- `dcos_public_agent_group`, creates a role, public ELB, and ASG of agents marked as public_slave
- `dcos_region`, creates s3 buckets and s3 vpc endpoint, you only need one of these per region
- `dcos_spot_asg`, the same as `dcos_asg` but sets a spot price
- `default_sec_group`, the default security group that all DC/OS components (nodes and ELBs) have to allow for communcation
- `ecr`, creates the `ecr_cred_lambda` as well as `ecr_repo`
- `ecr_cred_lambda`, creates a lambda function for writing docker credentials to s3
- `ecr_repo`, creates a number of ECR repos and makes the images readable by all

### Override Files

The `files` directory, contains a few different scripts. If you want to override behavior of these you should generally
be able to:

- Copy the files locally
- Customize as you see fit
- Path this path to the relevant module, overriding the including config

The three current places this technique are used are:

- `files/bootstrap/build_upload.sh`, 'dcos_bootstrap' call this script to build and upload the DC/OS package, set `build_script_path` to override
- `files/ecr_writer/build_docker.sh`, gets called to build the lambda function used in `ecr_cred_lambda` and upload it to s3, to override this, you need to provide `lambda_package_path` with a script that uploads a lambda package the specified s3 path
- `files/user_data/cloud-config.yaml.tpl`, `dcos_asg` and `dcos_asg_spot` use this template for user data. Set `cloud_config_template` to a custom template to override.

# Notes

### Docker Notes

Currently, the `dcos_generate_config.sh` script only runs in linux and itself makes use of docker. To make this
work on OSX, the script that builds the bootstrap package runs a priviliged docker image and
requires that you use a docker setup where the host can properly use volumes in arbitary locations. On OSX, this means
using either Docker For Mac of dinghy, on linux, it should just work

### Roadmap

- Add in a VPC module for a basic VPC setup
- Create a 'root' module that replicates almost everything the default DC/OS cloudformation does
- Add in Cloudwatch monitoring
- Add in more machine options, such as spot block and spot fleet support

### Contributing

All contributions are welcome! To contribute:

1. Open an issue dicsussing any major changes you want to make (for smaller changes, feel free to skip this)
2. Fork the project
3. Make your changes and run the validate.sh script to ensure it doesn't have any errors
4. Open a pull request
