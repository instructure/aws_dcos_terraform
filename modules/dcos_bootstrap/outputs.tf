output "dcos_install_url" {
  value = "${format("http://%s.s3.amazonaws.com/%s", var.bootstrap_bucket, replace(aws_s3_bucket_object.finished_upload.id, var.finished_file, var.bootstrap_dl_file))}"
}
