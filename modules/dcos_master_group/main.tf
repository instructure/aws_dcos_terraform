module "master_public_lb" {
  source = "../dcos_lb"
  env_name = "${var.env_name}"
  name = "dcos-master"
  vpc_id = "${var.vpc_id}"
  network = "${var.network}"
  subnets = "${var.public_subnets}"
  internal_lb = false
  default_security_group = "${var.default_security_group}"
  health_check_path = "HTTP:5050/health"
}

resource "aws_security_group_rule" "allow_all_http" {
  security_group_id = "${module.master_public_lb.sec_group}"
  type = "ingress"
  from_port = 80
  to_port = 80
  protocol = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "allow_all_https" {
  security_group_id = "${module.master_public_lb.sec_group}"
  type = "ingress"
  from_port = 443
  to_port = 443
  protocol = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
}


module "master_role" {
  source = "../dcos_master_role"
  env_name = "${var.env_name}"
  exhibitor_bucket = "${var.exhibitor_bucket}"
  work_bucket = "${var.work_bucket}"
  work_prefix = "${var.work_prefix}"
}

module "master_asg" {
  source = "../dcos_asg"
  aws_region = "${var.aws_region}"
  region_azs = "${var.region_azs}"
  vpc_id = "${var.vpc_id}"
  subnets = "${var.private_subnets}"
  default_security_group = "${var.default_security_group}"

  env_name = "${var.env_name}"
  name = "dcos-master"

  elbs = "${var.master_internal_lb},${module.master_public_lb.elb}"
  dcos_role = "master"
  cloud_config_template = "${var.cloud_config_template}"
  dcos_install_url = "${var.dcos_install_url}"

  role_arn = "${module.master_role.instance_profile_arn}"

  health_check_type = "ELB"
  health_check_grace_period = 900

  key_name = "${var.key_name}"
  extra_security_groups = "${var.extra_security_groups}"
  coreos_ami = "${var.coreos_ami}"
  instance_type = "${var.instance_type}"
  root_volume_size = "${var.root_volume_size}"
  max_size = "${var.max_size}"
  min_size = "${var.min_size}"
  desired_capacity = "${var.desired_capacity}"
}
