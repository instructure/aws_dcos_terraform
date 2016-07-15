output "launch_config" {
  value = "${module.master_asg.launch_config}"
}

output "asg" {
  value = "${module.master_asg.asg}"
}

output "asg_sec_group" {
  value = "${module.master_asg.sec_group}"
}

output "role_arn" {
  value = "${module.master_role.role_arn}"
}

output "role_id" {
  value = "${module.master_role.role_id}"
}

output "instance_profile_arn" {
  value = "${module.master_role.instance_profile_arn}"
}

output "public_lb_dns" {
  value = "${module.master_public_lb.elb_dns}"
}

output "public_lb" {
  value = "${module.master_public_lb.elb}"
}

output "public_lb_sec_group" {
  value = "${module.master_public_lb.sec_group}"
}
