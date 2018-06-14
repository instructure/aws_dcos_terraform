variable "region" {
  default = "us-east-1"
}

variable "name" {
  description = "a name to specify your dcos env, should be something unique!"
}

variable "vpc_id" {}

variable "route_table_ids" {
  description = "the route tables to place the s3 private endpoint"
  type        = "list"
}

variable "endpoint_id" {
  description = "an existing vpc s3 endpoint to use, disables creating a vpc endpoint"
  default     = ""
}

variable "full_bucket_name" {
  default     = ""
  description = "specify the full s3 bucket name if you require"
}
