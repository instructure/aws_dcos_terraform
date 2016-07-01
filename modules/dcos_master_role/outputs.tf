output "role_id" {
  value = "${aws_iam_role.master_role.id}"
}
output "role_arn" {
  value = "${aws_iam_role.master_role.arn}"
}
output "role_name" {
  value = "${aws_iam_role.master_role.name}"
}

output "instance_profile_arn" {
  value = "${aws_iam_instance_profile.master_profile.arn}"
}

output "primary_policy_name" {
  value = "${aws_iam_role_policy.master_role_primary.name}"
}


