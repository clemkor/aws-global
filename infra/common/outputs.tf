output "domain_name" {
  value = "${var.domain_name}"
}

output "public_dns_zone_id" {
  value = "${aws_route53_zone.public.id}"
}

output "private_dns_zone_id" {
  value = "${aws_route53_zone.private.id}"
}
