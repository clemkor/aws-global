data "aws_vpc" "default" {
  default = true
}

resource "aws_route53_zone" "public" {
  name = "${var.domain_name}"
}

resource "aws_route53_zone" "private" {
  name = "${var.domain_name}"
  vpc_id = "${data.aws_vpc.default.id}"
}
