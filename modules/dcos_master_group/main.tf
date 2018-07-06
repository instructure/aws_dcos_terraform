module "master_public_lb" {
  source                 = "../dcos_lb"
  cluster_name           = "${var.cluster_name}"
  name                   = "dcos-master"
  vpc_id                 = "${var.vpc_id}"
  network                = "${var.network}"
  subnets                = "${var.public_subnets}"
  internal_lb            = false
  default_security_group = "${var.default_security_group}"
  health_check_path      = "HTTP:5050/health"
  idle_timeout           = "${var.idle_timeout}"
  ssl_arn                = "${var.ssl_arn}"
}

resource "aws_security_group_rule" "allow_all_http" {
  security_group_id = "${module.master_public_lb.sec_group}"
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "allow_all_https" {
  security_group_id = "${module.master_public_lb.sec_group}"
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
}

module "master_role" {
  source           = "../dcos_master_role"
  cluster_name     = "${var.cluster_name}"
  exhibitor_bucket = "${var.exhibitor_bucket}"
  work_bucket      = "${var.work_bucket}"
  work_prefix      = "${var.work_prefix}"
}

module "master_asg" {
  source                 = "../dcos_asg"
  region                 = "${var.region}"
  region_azs             = "${var.region_azs}"
  subnets                = "${var.private_subnets}"
  default_security_group = "${var.default_security_group}"

  cluster_name = "${var.cluster_name}"

  load_balancers        = ["${var.master_internal_lb}", "${module.master_public_lb.elb}"]
  dcos_role             = "master"
  cloud_config_template = "${var.cloud_config_template}"
  bucket_name           = "${var.bucket_name}"
  dcos_version          = "${var.dcos_version}"
  dcos_install_path     = "${var.dcos_install_path}"

  iam_role_name = "${module.master_role.role_name}"

  health_check_type         = "ELB"
  health_check_grace_period = 900

  key_name         = "${var.key_name}"
  security_groups  = "${var.extra_security_groups}"
  coreos_ami       = "${var.coreos_ami}"
  instance_type    = "${var.instance_type}"
  root_volume_size = "${var.root_volume_size}"
  max_size         = "${var.max_size}"
  min_size         = "${var.min_size}"
  desired_capacity = "${var.desired_capacity}"
  tags             = "${var.tags}"

  enable_init_hook          = "${var.enable_init_hook}"
  override_asg_name         = "${var.override_asg_name}"
  override_launch_hook_name = "${var.override_launch_hook_name}"
  lifecycle_action_result   = "${var.lifecycle_action_result}"
}
