variable "aws_region" {
  default = "us-east-1"
}

variable "vpc_id" {}
// needed for adding the s3 endpoint to the route tables
variable "route_table_ids" {}
