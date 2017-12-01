# This ASG allows for all DCOS components to
# 1. have all outbound traffic
# 2. communicate to each other on all ports
# 3. open up ssh and icmp to the VPC
resource "aws_security_group" "dcos_default" {
  name        = "${var.cluster_name}-dcos-default"
  description = "default SG for all dcos components"
  vpc_id      = "${var.vpc_id}"
}

resource "aws_security_group_rule" "dcos_default_out" {
  security_group_id = "${aws_security_group.dcos_default.id}"
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "default_self" {
  security_group_id = "${aws_security_group.dcos_default.id}"
  type              = "ingress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  self              = true
}

resource "aws_security_group_rule" "default_icmp" {
  security_group_id = "${aws_security_group.dcos_default.id}"
  type              = "ingress"
  from_port         = 0
  to_port           = 0
  protocol          = "icmp"
  cidr_blocks       = ["${var.network}"]
}

resource "aws_security_group_rule" "default_ssh" {
  security_group_id = "${aws_security_group.dcos_default.id}"
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["${var.network}"]
}
