output "launch_config" {
  value = "${aws_launch_configuration.cluster.id}"
}

output "asg" {
  value = "${element(coalescelist(aws_autoscaling_group.cluster_hook.*.id, aws_autoscaling_group.cluster_no_hook.*.id), 0)}"
}
