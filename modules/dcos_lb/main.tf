# This ELB is primarily used for balancing for instances of marathon-lb or adminrouter, so we forward just http and https in tcp mode
resource "aws_elb" "lb-nossl" {
  count           = "${var.ssl_arn == "" ? 1 : 0}"
  name            = "dcos-${var.cluster_name}-${var.name}"
  subnets         = ["${var.subnets}"]
  internal        = "${var.internal_lb}"
  security_groups = ["${var.default_security_group}", "${compact(concat(list(aws_security_group.lb.id), var.extra_security_groups))}"]

  // haproxy tcp
  listener {
    instance_port     = "${var.http_instance_port}"
    instance_protocol = "tcp"
    lb_port           = 80
    lb_protocol       = "tcp"
  }

  // haproxy https
  listener {
    instance_port     = "${var.https_instance_port}"
    instance_protocol = "tcp"
    lb_port           = 443
    lb_protocol       = "tcp"
  }

  cross_zone_load_balancing = "${var.cross_zone_load_balancing}"
  idle_timeout              = "${var.idle_timeout}"

  health_check {
    target              = "${var.health_check_path}"
    healthy_threshold   = 2
    unhealthy_threshold = 2
    interval            = 30
    timeout             = 5
  }
}

resource "aws_elb" "lb-ssl" {
  count           = "${var.ssl_arn == "" ? 0 : 1}"
  name            = "dcos-${var.cluster_name}-${var.name}"
  subnets         = ["${var.subnets}"]
  internal        = "${var.internal_lb}"
  security_groups = ["${var.default_security_group}", "${compact(concat(list(aws_security_group.lb.id), var.extra_security_groups))}"]

  // TODO: for now, disable http when we have an SSL cert
  /*
  listener {
    instance_port     = "${var.http_instance_port}"
    instance_protocol = "tcp"
    lb_port           = 80
    lb_protocol       = "tcp"
  }*/

  // use ELB to terminate SSL
  listener {
    instance_port      = "${var.https_instance_port}"
    instance_protocol  = "https"
    lb_port            = 443
    lb_protocol        = "https"
    ssl_certificate_id = "${var.ssl_arn}"
  }
  cross_zone_load_balancing = "${var.cross_zone_load_balancing}"
  idle_timeout              = "${var.idle_timeout}"
  health_check {
    target              = "${var.health_check_path}"
    healthy_threshold   = 2
    unhealthy_threshold = 2
    interval            = 30
    timeout             = 5
  }
}

resource "aws_security_group" "lb" {
  name        = "dcos-${var.cluster_name}-${var.name}-agent-lb"
  description = "sec group for the ${var.cluster_name}-${var.name} ELB"
  vpc_id      = "${var.vpc_id}"
}

# default to at least allowing things inter network, add more rules for more!
resource "aws_security_group_rule" "lb_all" {
  security_group_id = "${aws_security_group.lb.id}"
  type              = "ingress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["${var.network}"]
}
