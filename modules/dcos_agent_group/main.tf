module "agent_internal_lb" {
  source                 = "../dcos_lb"
  cluster_name           = "${var.cluster_name}"
  name                   = "agent"
  vpc_id                 = "${var.vpc_id}"
  network                = "${var.network}"
  subnets                = "${var.private_subnets}"
  http_instance_port     = "${var.http_instance_port}"
  https_instance_port    = "${var.https_instance_port}"
  internal_lb            = true
  default_security_group = "${var.default_security_group}"
  idle_timeout           = "${var.idle_timeout}"
}

module "agent_role" {
  source       = "../dcos_agent_role"
  cluster_name = "${var.cluster_name}"
  agent_type   = "internal"
  work_bucket  = "${var.work_bucket}"
  work_prefix  = "${var.work_prefix}"
}

module "agent_asg" {
  source                 = "../dcos_asg"
  region                 = "${var.region}"
  region_azs             = "${var.region_azs}"
  subnets                = "${var.private_subnets}"
  default_security_group = "${var.default_security_group}"

  cluster_name = "${var.cluster_name}"

  load_balancers        = ["${module.agent_internal_lb.elb}"]
  dcos_role             = "slave"
  cloud_config_template = "${var.cloud_config_template}"
  bucket_name           = "${var.bucket_name}"
  dcos_version          = "${var.dcos_version}"
  dcos_install_path     = "${var.dcos_install_path}"

  iam_role_name = "${module.agent_role.role_name}"

  key_name         = "${var.key_name}"
  security_groups  = "${var.extra_security_groups}"
  coreos_ami       = "${var.coreos_ami}"
  instance_type    = "${var.instance_type}"
  root_volume_size = "${var.root_volume_size}"
  max_size         = "${var.max_size}"
  min_size         = "${var.min_size}"
  desired_capacity = "${var.desired_capacity}"
  tags             = "${var.tags}"
}
