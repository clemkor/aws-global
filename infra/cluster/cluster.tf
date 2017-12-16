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

  cluster_instance_root_block_device_size = "${var.cluster_instance_root_block_device_size}"
  cluster_instance_docker_block_device_size = "${var.cluster_instance_docker_block_device_size}"

  cluster_instance_amis = {
    us-east-1 = "ami-fad25980"
    us-east-2 = "ami-58f5db3d"
    us-west-1 = "ami-62e0d802"
    us-west-2 = "ami-7114c909"
    eu-west-1 = "ami-4cbe0935"
    eu-west-2 = "ami-dbfee1bf"
    eu-central-1 = "ami-05991b6a"
    ap-northeast-1 = "ami-56bd0030"
    ap-northeast-2 = "ami-7267c01c"
    ap-southeast-1 = "ami-1bdc8b78"
    ap-southeast-2 = "ami-14b55f76"
    ca-central-1 = "ami-918b30f5"
    ap-south-1 = "ami-e4d29c8b"
    sa-east-1 = "ami-d596d2b9"
  }
}
