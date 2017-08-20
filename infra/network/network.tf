data "aws_availability_zones" "all" {}

data "aws_ami" "amazon_linux" {
  most_recent = true
  owners = ["amazon"]

  name_regex = "^amzn-ami-hvm-\\d{4}\\.\\d{2}\\.\\d*"

  filter {
    name = "name"
    values = ["amzn-ami-hvm-*-gp2"]
  }
}

module "network" {
  source = "github.com/infrablocks/terraform-aws-base-networking?ref=0.1.11//src"

  region = "${var.region}"
  availability_zones = "${join(",", data.aws_availability_zones.all.names)}"
  vpc_cidr = "${var.vpc_cidr}"

  component = "${var.component}"
  deployment_identifier = "${var.deployment_identifier}"

  bastion_ami = "${data.aws_ami.amazon_linux.id}"
  bastion_ssh_public_key_path = "${var.bastion_ssh_public_key_path}"
  bastion_ssh_allow_cidrs = "${join(",", var.bastion_ssh_allow_cidrs)}"

  domain_name = "${data.terraform_remote_state.common.domain_name}"
  public_zone_id = "${data.terraform_remote_state.common.public_dns_zone_id}"
  private_zone_id = "${data.terraform_remote_state.common.private_dns_zone_id}"

  include_lifecycle_events = "no"
}