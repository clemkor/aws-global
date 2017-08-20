data "terraform_remote_state" "network" {
  backend = "s3"

  config {
    bucket = "${var.state_bucket}"
    key = "${var.network_state_key}"
    region = "${var.region}"
  }
}