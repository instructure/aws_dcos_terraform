// used so we can get http URLs to work for some buckets
resource "aws_vpc_endpoint" "private_s3" {
  count           = "${var.endpoint_id == "" ? 1 : 0}"
  vpc_id          = "${var.vpc_id}"
  service_name    = "com.amazonaws.${var.region}.s3"
  route_table_ids = ["${var.route_table_ids}"]
}

resource "aws_s3_bucket" "util_bucket" {
  bucket = "dcos-${var.name}-util-${var.region}"
  acl    = "private"

  // use a custom policy so that HTTP urls work inside the bucket to fetch utils!
  policy = <<EOF
{
   "Version": "2012-10-17",
   "Id": "Policy1415115909152",
   "Statement": [
     {
       "Sid": "AccessViaVPCE",
       "Action": [
         "s3:Get*",
         "s3:List*"
       ],
       "Effect": "Allow",
       "Resource": ["arn:aws:s3:::dcos-${var.name}-util-${var.region}",
                    "arn:aws:s3:::dcos-${var.name}-util-${var.region}/*"],
       "Condition": {
         "StringEquals": {
           "aws:sourceVpce": "${coalesce(var.endpoint_id, element(compact(concat(aws_vpc_endpoint.private_s3.*.id, list("default"))), 0))}"
         }
       },
       "Principal": "*"
     }
   ]
}
EOF
}
