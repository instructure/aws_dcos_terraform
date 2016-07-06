output "elb_dns" {
  value = "${aws_elb.lb.dns_name}"
}

output "elb" {
  value = "${aws_elb.lb.id}"
}

output "sec_group" {
  value = "${aws_security_group.lb.id}"
}
