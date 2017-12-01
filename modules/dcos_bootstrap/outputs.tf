output "dcos_install_path" {
  value = "${format("s3://%s/%s", var.bucket, replace(aws_s3_bucket_object.finished_upload.id, var.finished_file, ""))}"
}
