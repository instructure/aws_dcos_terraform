module "default_sec_group" {
  source = "../default_sec_group"
  env_name = "${var.env_name}"
  vpc_id = "${var.vpc_id}"
  network = "${var.network}"
}

module "master_internal_lb" {
  source = "../dcos_master_internal_lb"
  env_name = "${var.env_name}"
  vpc_id = "${var.vpc_id}"
  network = "${var.network}"
  private_subnets = "${var.private_subnets}"
  default_security_group = "${module.default_sec_group.id}"
  extra_security_groups = "${var.extra_master_internal_sec_groups}"
}

module "dcos_bootstrap" {
  source = "../dcos_bootstrap"
  aws_region = "${var.aws_region}"
  env_name = "${var.env_name}"
  master_elb_dns = "${module.master_internal_lb.elb_dns}"
  exhibitor_bucket = "${var.exhibitor_bucket}"
  bootstrap_bucket = "${var.bootstrap_bucket}"
  build_script_path = "${var.bootstrap_build_script_path}"
}

module "masters" {
  source = "../dcos_master_group"
  aws_region = "${var.aws_region}"
  region_azs = "${var.region_azs}"
  vpc_id = "${var.vpc_id}"
  network = "${var.network}"
  env_name = "${var.env_name}"
  key_name = "${var.key_name}"
  public_subnets = "${var.public_subnets}"
  private_subnets = "${var.private_subnets}"
  coreos_ami = "${var.coreos_ami}"
  instance_type = "${var.master_instance_type}"
  default_security_group = "${module.default_sec_group.id}"
  extra_security_groups = "${var.extra_master_sec_groups}"
  root_volume_size = "${var.master_root_volume_size}"
  max_size = "${var.master_count}"
  min_size = "${var.master_count}"
  desired_capacity = "${var.master_count}"
  master_internal_lb = "${module.master_internal_lb.elb}"
  cloud_config_template = "${var.master_cloud_config_template}"
  dcos_install_url = "${module.dcos_bootstrap.dcos_install_url}"
  exhibitor_bucket = "${var.exhibitor_bucket}"
  work_bucket = "${var.bootstrap_bucket}"
}

module "agents" {
  source = "../dcos_agent_group"
  aws_region = "${var.aws_region}"
  region_azs = "${var.region_azs}"
  vpc_id = "${var.vpc_id}"
  network = "${var.network}"
  env_name = "${var.env_name}"
  key_name = "${var.key_name}"
  private_subnets = "${var.private_subnets}"
  coreos_ami = "${var.coreos_ami}"
  instance_type = "${coalesce(var.private_agent_instance_type, var.agent_instance_type)}"
  default_security_group = "${module.default_sec_group.id}"
  extra_security_groups = "${var.extra_agent_sec_groups}"
  root_volume_size = "${var.agent_root_volume_size}"
  max_size = "${var.max_agent_count}"
  min_size = "${var.min_agent_count}"
  desired_capacity = "${var.agent_count}"
  cloud_config_template = "${var.agent_cloud_config_template}"
  dcos_install_url = "${module.dcos_bootstrap.dcos_install_url}"
  work_bucket = "${var.bootstrap_bucket}"
}

module "public_agents" {
  source = "../dcos_public_agent_group"
  aws_region = "${var.aws_region}"
  region_azs = "${var.region_azs}"
  vpc_id = "${var.vpc_id}"
  network = "${var.network}"
  env_name = "${var.env_name}"
  key_name = "${var.key_name}"
  instance_subnets = "${var.private_subnets}"
  elb_subnets = "${var.public_subnets}"
  coreos_ami = "${var.coreos_ami}"
  instance_type = "${coalesce(var.public_agent_instance_type, var.agent_instance_type)}"
  default_security_group = "${module.default_sec_group.id}"
  extra_security_groups = "${var.extra_public_agent_sec_groups}"
  root_volume_size = "${var.public_agent_root_volume_size}"
  max_size = "${var.max_public_agent_count}"
  min_size = "${var.min_public_agent_count}"
  desired_capacity = "${var.public_agent_count}"
  cloud_config_template = "${var.public_agent_cloud_config_template}"
  dcos_install_url = "${module.dcos_bootstrap.dcos_install_url}"
  work_bucket = "${var.bootstrap_bucket}"
}
