# builds the bootstrap package and uploads it to s3
resource "null_resource" "build_upload" {
  triggers {
    dns_name         = "${var.master_elb_dns}"
    env_name         = "${var.env_name}"
    exhibitor_bucket = "${var.exhibitor_bucket}"
    boostrap_bucket  = "${var.bootstrap_bucket}"
  }

  provisioner "local-exec" {
    command = "AWS_REGION=${var.aws_region} ${coalesce(var.build_script_path, format("%s/files/bootstrap/build_upload.sh", path.module))} ${var.env_name} ${var.exhibitor_bucket} ${var.env_name} ${var.master_elb_dns} ${format("http://%s.s3.amazonaws.com/%s", var.bootstrap_bucket, var.env_name)} ${format("s3://%s/%s", var.bootstrap_bucket, var.env_name)}"
  }
}

# this is a bit of a hack, we use this resource to depend on build_upload resource
# and then rely on an output from this file, this ensures that any dependencies
# happen after build_upload has finished
resource "aws_s3_bucket_object" "finished_upload" {
  depends_on = ["null_resource.build_upload"]
  bucket     = "${var.bootstrap_bucket}"
  key        = "${var.env_name}/${var.finished_file}"
  content    = "${var.env_name}"
}
