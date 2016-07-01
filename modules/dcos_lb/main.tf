# This ELB is primarily used for balancing for instances of marathon-lb or adminrouter, so we forward just http and https in tcp mode
resource "aws_elb" "lb" {
  name = "${var.env_name}-${var.name}"
  subnets = ["${split(",", var.subnets)}"]
  internal = "${var.internal_lb}"
  security_groups = ["${var.default_security_group}", "${compact(concat(aws_security_group.lb.id, split(",", var.extra_security_groups)))}"]
  // haproxy tcp
  listener {
    instance_port = 80
    instance_protocol = "tcp"
    lb_port = 80
    lb_protocol = "tcp"
  }
  // haproxy https
  listener {
    instance_port = 443
    instance_protocol = "tcp"
    lb_port = 443
    lb_protocol = "tcp"
  }

  health_check {
    target = "${var.health_check_path}"
    healthy_threshold = 2
    unhealthy_threshold = 2
    interval = 30
    timeout = 5
  }
}

resource "aws_security_group" "lb" {
  name = "${var.env_name}-${var.name}-agent-lb"
  description = "sec group for the ${var.env_name}-${var.name} ELB"
  vpc_id = "${var.vpc_id}"
}

# default to at least allowing things inter network, add more rules for more!
resource "aws_security_group_rule" "lb_all" {
  security_group_id = "${aws_security_group.lb.id}"
  type = "ingress"
  from_port = 0
  to_port = 0
  protocol = "-1"
  cidr_blocks = ["${var.network}"]
}
