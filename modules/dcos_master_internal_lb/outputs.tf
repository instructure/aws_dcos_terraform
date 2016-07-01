output "elb_dns" {
  value = "${aws_elb.master_internal_lb.dns_name}"
}
output "elb" {
  value = "${aws_elb.master_internal_lb.id}"
}
output "sec_group" {
  value = "${aws_security_group.master_internal_lb.id}"
}
