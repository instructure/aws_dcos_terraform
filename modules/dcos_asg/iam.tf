resource "aws_iam_instance_profile" "cluster" {
  name_prefix = "dcos-${var.cluster_name}-"
  role        = "${var.iam_role_name}"
}
