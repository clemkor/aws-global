data "terraform_remote_state" "common" {
  backend = "s3"

  config {
    bucket = "${var.state_bucket}"
    key = "${var.state_common_key}"
    region = "${var.region}"
  }
}