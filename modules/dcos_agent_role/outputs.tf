output "role_id" {
  value = "${aws_iam_role.agent_role.id}"
}
output "role_arn" {
  value = "${aws_iam_role.agent_role.arn}"
}
output "role_name" {
  value = "${aws_iam_role.agent_role.name}"
}

output "instance_profile_arn" {
  value = "${aws_iam_instance_profile.agent_profile.arn}"
}

output "primary_policy_name" {
  value = "${aws_iam_role_policy.agent_role_primary.name}"
}


