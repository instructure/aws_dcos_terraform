// used so we can get http URLs to work for some buckets
resource "aws_vpc_endpoint" "private_s3" {
  vpc_id = "${var.vpc_id}"
  service_name = "com.amazonaws.${var.aws_region}.s3"
  route_table_ids = ["${split(",", var.route_table_ids)}"]
}

resource "aws_s3_bucket" "bootstrap_bucket" {
  bucket = "dcos-bootstrap-${var.aws_region}"
  acl = "private"

// use a custom policy so that HTTP urls work inside the bucket to fetch bootstraps!
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
       "Resource": ["arn:aws:s3:::dcos-bootstrap-${var.aws_region}",
                    "arn:aws:s3:::dcos-bootstrap-${var.aws_region}/*"],
       "Condition": {
         "StringEquals": {
           "aws:sourceVpce": "${aws_vpc_endpoint.private_s3.id}"
         }
       },
       "Principal": "*"
     }
   ]
}
EOF
}

// jsut assume usual IAM roles for this access
resource "aws_s3_bucket" "exhibitor_bucket" {
  bucket = "dcos-exhibitor-${var.aws_region}"
  acl = "private"
}
