output "bootstrap_bucket" {
  value = "${aws_s3_bucket.bootstrap_bucket.id}"
}
output "exhibitor_bucket" {
  value = "${aws_s3_bucket.exhibitor_bucket.id}"
}
