output "default_security_group" {
  value = "${module.default_sec_group.id}"
}

output "master_internal_elb_dns" {
  value = "${module.master_internal_lb.elb_dns}"
}

output "master_internal_elb" {
  value = "${module.master_internal_lb.elb}"
}

output "master_internal_sec_group" {
  value = "${module.master_internal_lb.sec_group}"
}

output "dcos_install_path" {
  value = "${module.dcos_bootstrap.dcos_install_path}"
}

output "master_launch_config" {
  value = "${module.masters.launch_config}"
}

output "master_asg" {
  value = "${module.masters.asg}"
}

output "master_role_arn" {
  value = "${module.masters.role_arn}"
}

output "master_role_id" {
  value = "${module.masters.role_id}"
}

output "master_instance_profile_arn" {
  value = "${module.masters.instance_profile_arn}"
}

output "master_public_lb_dns" {
  value = "${module.masters.public_lb_dns}"
}

output "master_public_lb" {
  value = "${module.masters.public_lb}"
}

output "master_public_lb_sec_group" {
  value = "${module.masters.public_lb_sec_group}"
}

output "agent_launch_config" {
  value = "${module.agents.launch_config}"
}

output "agent_asg" {
  value = "${module.agents.asg}"
}

output "agent_role_arn" {
  value = "${module.agents.role_arn}"
}

output "agent_role_id" {
  value = "${module.agents.role_id}"
}

output "agent_instance_profile_arn" {
  value = "${module.agents.instance_profile_arn}"
}

output "agent_lb_dns" {
  value = "${module.agents.lb_dns}"
}

output "agent_lb" {
  value = "${module.agents.lb}"
}

output "agent_lb_sec_group" {
  value = "${module.agents.lb_sec_group}"
}

output "public_agent_launch_config" {
  value = "${module.public_agents.launch_config}"
}

output "public_agent_asg" {
  value = "${module.public_agents.asg}"
}

output "public_agent_role_arn" {
  value = "${module.public_agents.role_arn}"
}

output "public_agent_role_id" {
  value = "${module.public_agents.role_id}"
}

output "public_agent_instance_profile_arn" {
  value = "${module.public_agents.instance_profile_arn}"
}

output "public_agent_lb_dns" {
  value = "${module.public_agents.lb_dns}"
}

output "public_agent_lb" {
  value = "${module.public_agents.lb}"
}

output "public_agent_lb_sec_group" {
  value = "${module.public_agents.lb_sec_group}"
}
