output "launch_config" {
  value = "${module.agent_asg.launch_config}"
}

output "asg" {
  value = "${module.agent_asg.asg}"
}

output "role_arn" {
  value = "${module.agent_role.role_arn}"
}

output "role_id" {
  value = "${module.agent_role.role_id}"
}

output "instance_profile_arn" {
  value = "${module.agent_role.instance_profile_arn}"
}

output "lb_dns" {
  value = "${module.agent_internal_lb.elb_dns}"
}

output "lb" {
  value = "${module.agent_internal_lb.elb}"
}

output "lb_sec_group" {
  value = "${module.agent_internal_lb.sec_group}"
}
