# builds the bootstrap package and uploads it to s3
resource "null_resource" "build_upload" {
  triggers {
    dns_name         = "${var.master_elb_dns}"
    env_name         = "${var.env_name}"
    exhibitor_bucket = "${var.exhibitor_bucket}"
    boostrap_bucket  = "${var.bootstrap_bucket}"
    dcos_url         = "${var.dcos_url}"
    version          = "${var.version}"
  }

  provisioner "local-exec" {
    command = "AWS_REGION=${var.aws_region} DCOS_URL=${var.dcos_url} ${coalesce(var.build_script_path, format("%s/files/bootstrap/build_upload.sh", path.module))} ${var.env_name} ${var.exhibitor_bucket} ${var.env_name} ${var.master_elb_dns} ${format("http://%s.s3.amazonaws.com/%s/%s", var.bootstrap_bucket, var.env_name, var.version)} ${format("s3://%s/%s/%s", var.bootstrap_bucket, var.env_name, var.version)}"
  }
}

# this is a bit of a hack, we use this resource to depend on build_upload resource
# and then rely on an output from this file, this ensures that any dependencies
# happen after build_upload has finished
resource "aws_s3_bucket_object" "finished_upload" {
  depends_on = ["null_resource.build_upload"]
  bucket     = "${var.bootstrap_bucket}"
  key        = "${var.env_name}/${var.version}/${var.finished_file}"
  content    = "${var.env_name}"
}
