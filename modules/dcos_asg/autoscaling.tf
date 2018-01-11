resource "aws_autoscaling_group" "cluster_hook" {
  count                     = "${var.enable_init_hook ? 1 : 0}"
  name_prefix               = "${coalesce(var.group_prefix, "dcos-${var.cluster_name}-${var.dcos_role}-")}"
  availability_zones        = ["${formatlist("%s%s", var.region, var.region_azs)}"]
  max_size                  = "${var.max_size}"
  min_size                  = "${var.min_size}"
  desired_capacity          = "${var.desired_capacity}"
  health_check_type         = "${var.health_check_type}"
  health_check_grace_period = "${var.health_check_grace_period}"

  load_balancers       = ["${var.load_balancers}"]
  launch_configuration = "${aws_launch_configuration.cluster.name}"
  vpc_zone_identifier  = ["${var.subnets}"]

  tags = ["${
    concat(var.tags, list(
      map("key", "Role", "value", "${title(var.dcos_role)}", "propagate_at_launch", true),
      map("key", "DCOSCluster", "value", "${var.cluster_name}", "propagate_at_launch", true),
      map("key", "DCOSVersion", "value", "${var.dcos_version}", "propagate_at_launch", true)
    ))
  }"]

  initial_lifecycle_hook {
    name                 = "${coalesce(var.override_launch_hook_name, format("%s-%s-launch", var.cluster_name, var.dcos_role))}"
    default_result       = "CONTINUE"
    heartbeat_timeout    = "${var.asg_wait_time}"
    lifecycle_transition = "autoscaling:EC2_INSTANCE_LAUNCHING"
  }


  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "cluster_no_hook" {
  count                     = "${var.enable_init_hook ? 0 : 1}"
  name_prefix               = "${coalesce(var.group_prefix, "dcos-${var.cluster_name}-${var.dcos_role}-")}"
  availability_zones        = ["${formatlist("%s%s", var.region, var.region_azs)}"]
  max_size                  = "${var.max_size}"
  min_size                  = "${var.min_size}"
  desired_capacity          = "${var.desired_capacity}"
  health_check_type         = "${var.health_check_type}"
  health_check_grace_period = "${var.health_check_grace_period}"

  load_balancers       = ["${var.load_balancers}"]
  launch_configuration = "${aws_launch_configuration.cluster.name}"
  vpc_zone_identifier  = ["${var.subnets}"]

  tags = ["${
    concat(var.tags, list(
      map("key", "Role", "value", "${title(var.dcos_role)}", "propagate_at_launch", true),
      map("key", "DCOSCluster", "value", "${var.cluster_name}", "propagate_at_launch", true),
      map("key", "DCOSVersion", "value", "${var.dcos_version}", "propagate_at_launch", true)
    ))
  }"]

  lifecycle {
    create_before_destroy = true
  }
}
