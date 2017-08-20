resource "aws_s3_bucket" "components" {
  bucket = "${var.components_bucket_name}"
  acl = "private"

  versioning {
    enabled = true
  }

  tags {
    Name = "bucket-${var.components_bucket_name}"
  }
}
