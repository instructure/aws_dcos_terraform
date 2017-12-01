data "aws_s3_bucket" "cluster" {
  bucket = "${var.bucket}"
}

locals {
  script_path_default = "${format("%s/scripts/build_upload.sh", path.module)}"
  script_path         = "${coalesce(var.build_script_path, local.script_path_default)}"
}

resource "null_resource" "build_package" {
  triggers {
    cluster_name       = "${var.cluster_name}"
    num_masters        = "${var.num_masters}"
    bucket             = "${var.bucket}"
    master_elb_dnsname = "${var.master_elb_dnsname}"
    dcos_version       = "${var.dcos_version}"
  }

  provisioner "local-exec" {
    command = "AWS_REGION=${var.region} DCOS_URL=${var.dcos_url} DCOS_AWS_ROLE=${var.role_arn} ${local.script_path} ${var.cluster_name} ${var.num_masters} ${var.bucket} exhibitor_states/${var.cluster_name} ${var.master_elb_dnsname} ${var.dcos_version}"
  }
}

# this is a bit of a hack, we use this resource to depend on build_upload resource
# and then rely on an output from this file, this ensures that any dependencies
# happen after build_upload has finished
resource "aws_s3_bucket_object" "finished_upload" {
  depends_on = ["null_resource.build_package"]
  bucket     = "${var.bucket}"
  key        = "${var.cluster_name}/${var.dcos_version}/bootstrap/${var.finished_file}"
  content    = "${var.cluster_name}-${var.dcos_version}"
}
