resource "aws_launch_configuration" "dcos_lc" {
  name_prefix          = "${var.env_name}-${var.name}-"
  image_id             = "${var.coreos_ami}"
  instance_type        = "${var.instance_type}"
  iam_instance_profile = "${var.role_arn}"
  key_name             = "${var.key_name}"

  # we concat the primary group with the extra groups in the event that no extra security groups are passed,
  # we don't end up with an (invalid) empty array
  security_groups = ["${var.default_security_group}", "${compact(concat(aws_security_group.primary.id, split(",", var.extra_security_groups)))}"]

  root_block_device {
    volume_type = "gp2"
    volume_size = "${var.root_volume_size}"
  }

  ephemeral_block_device {
    device_name  = "/dev/sdb"
    virtual_name = "ephemeral0"
  }

  spot_price = "${var.spot_price}"
  user_data  = "${template_file.user_data.rendered}"

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "dcos_asg" {
  availability_zones        = ["${formatlist("%s%s", var.aws_region, split(",", var.region_azs))}"]
  name                      = "${var.env_name}-${var.name}"
  max_size                  = "${var.max_size}"
  min_size                  = "${var.min_size}"
  desired_capacity          = "${var.desired_capacity}"
  health_check_type         = "${var.health_check_type}"
  health_check_grace_period = "${var.health_check_grace_period}"
  load_balancers            = ["${compact(split(",", var.elbs))}"]
  launch_configuration      = "${aws_launch_configuration.dcos_lc.name}"
  vpc_zone_identifier       = ["${split(",", var.subnets)}"]

  tag {
    key                 = "Env"
    value               = "${var.env_name}"
    propagate_at_launch = true
  }

  tag {
    key                 = "asg_name"
    value               = "${var.name}"
    propagate_at_launch = true
  }

  tag {
    key                 = "role"
    value               = "${var.dcos_role}"
    propagate_at_launch = true
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "template_file" "user_data" {
  template = "${coalesce(var.cloud_config_template, file(format("%s/files/user_data/cloud-config.yaml.tpl", path.module)))}"

  vars {
    bootstrap_url = "${var.dcos_install_url}"
    role          = "${var.dcos_role}"
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_security_group" "primary" {
  name        = "${var.env_name}-${var.name}"
  description = "Open ports for ${var.name} group of machines"
  vpc_id      = "${var.vpc_id}"
}
