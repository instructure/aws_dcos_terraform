output "launch_config" {
  value = "${aws_launch_configuration.cluster.id}"
}

output "asg" {
  value = "${aws_autoscaling_group.cluster.id}"
}
