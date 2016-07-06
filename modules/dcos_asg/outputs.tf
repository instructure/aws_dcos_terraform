output "launch_config" {
  value = "${aws_launch_configuration.dcos_lc.id}"
}

output "asg" {
  value = "${aws_autoscaling_group.dcos_asg.id}"
}

output "sec_group" {
  value = "${aws_security_group.primary.id}"
}
