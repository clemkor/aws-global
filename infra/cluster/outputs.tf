output "cluster_id" {
  value = "${module.ecs_cluster.cluster_id}"
}
output "service_role_arn" {
  value = "${module.ecs_cluster.service_role_arn}"
}