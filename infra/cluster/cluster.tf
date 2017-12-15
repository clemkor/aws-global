module "ecs_cluster" {
  source = "github.com/infrablocks/terraform-aws-ecs-cluster?ref=0.2.1//src"

  region = "${var.region}"
  vpc_id = "${data.terraform_remote_state.network.vpc_id}"
  private_subnet_ids = "${data.terraform_remote_state.network.private_subnet_ids}"
  private_network_cidr = "${var.private_network_cidr}"

  component = "${var.component}"
  deployment_identifier = "${var.deployment_identifier}"

  cluster_instance_ssh_public_key_path = "${var.cluster_instance_ssh_public_key_path}"
  cluster_instance_type = "${var.cluster_instance_type}"

  cluster_minimum_size = "${var.cluster_minimum_size}"
  cluster_maximum_size = "${var.cluster_maximum_size}"
  cluster_desired_capacity = "${var.cluster_desired_capacity}"
}
