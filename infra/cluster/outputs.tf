output "id" {
  value = "${module.ecs_cluster.ecs_cluster_id}"
}
output "service_role_arn" {
  value = "${module.ecs_cluster.ecs_cluster_service_role_arn}"
}