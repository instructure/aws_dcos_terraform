output "launch_config" {
  value = "${module.agent_asg.launch_config}"
}

output "asg" {
  value = "${module.agent_asg.asg}"
}

output "asg_sec_group" {
  value = "${module.agent_asg.sec_group}"
}

output "role_arn" {
  value = "${module.agent_role.role_arn}"
}

output "role_id" {
  value = "${module.agent_role.role_id}"
}

output "lb_dns" {
  value = "${module.agent_public_lb.elb_dns}"
}

output "lb" {
  value = "${module.agent_public_lb.elb}"
}

output "lb_sec_group" {
  value = "${module.agent_public_lb.sec_group}"
}
