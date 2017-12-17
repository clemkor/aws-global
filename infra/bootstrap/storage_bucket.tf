module "storage_bucket" {
  source = "github.com/infrablocks/terraform-aws-encrypted-bucket?ref=0.1.10//src"

  region = "${var.region}"
  bucket_name = "${var.storage_bucket_name}"
}
