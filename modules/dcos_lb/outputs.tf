output "elb_dns" {
  value = "${element(coalescelist(aws_elb.lb-nossl.*.dns_name, aws_elb.lb-ssl.*.dns_name), 0)}"
}

output "elb" {
  value = "${element(coalescelist(aws_elb.lb-nossl.*.id, aws_elb.lb-ssl.*.id), 0)}"
}

output "sec_group" {
  value = "${aws_security_group.lb.id}"
}
