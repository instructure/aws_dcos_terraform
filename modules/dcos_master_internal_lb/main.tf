// used by agents to contact the master, also could be used for internal hitting the admin portal
resource "aws_elb" "master_internal_lb" {
  name            = "${var.env_name}-dcos-master-internal"
  subnets         = ["${split(",", var.private_subnets)}"]
  internal        = true
  security_groups = ["${var.default_security_group}", "${compact(concat(list(aws_security_group.master_internal_lb.id), split(",", var.extra_security_groups)))}"]

  // mesos-master
  listener {
    instance_port     = 5050
    instance_protocol = "http"
    lb_port           = 5050
    lb_protocol       = "http"
  }

  // zookeeper
  listener {
    instance_port     = 2181
    instance_protocol = "tcp"
    lb_port           = 2181
    lb_protocol       = "tcp"
  }

  // exhibitor
  listener {
    instance_port     = 8181
    instance_protocol = "http"
    lb_port           = 8181
    lb_protocol       = "http"
  }

  // web-ui
  listener {
    instance_port     = 80
    instance_protocol = "tcp"
    lb_port           = 80
    lb_protocol       = "tcp"
  }

  // web-ui-https
  listener {
    instance_port     = 443
    instance_protocol = "tcp"
    lb_port           = 443
    lb_protocol       = "tcp"
  }

  // marathon
  listener {
    instance_port     = 8080
    instance_protocol = "http"
    lb_port           = 8080
    lb_protocol       = "http"
  }

  health_check {
    target              = "HTTP:5050/health"
    healthy_threshold   = 2
    unhealthy_threshold = 2
    interval            = 30
    timeout             = 5
  }
}

// LB for internal masters
resource "aws_security_group" "master_internal_lb" {
  name        = "${var.env_name}-master-internal-lb"
  description = "Allow instances inside to hit the masters"
  vpc_id      = "${var.vpc_id}"
}

resource "aws_security_group_rule" "master_internal_lb_all" {
  security_group_id = "${aws_security_group.master_internal_lb.id}"
  type              = "ingress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["${var.network}"]
}
