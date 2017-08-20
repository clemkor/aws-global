output "vpc_id" {
  value = "${module.network.vpc_id}"
}

output "private_subnet_ids" {
  value = "${module.network.private_subnet_ids}"
}
