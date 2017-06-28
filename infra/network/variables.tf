variable "region" {}
variable "vpc_cidr" {}

variable "component" {}
variable "deployment_identifier" {}

variable "bastion_ssh_public_key_path" {}
variable "bastion_ssh_allow_cidrs" {
  type = "list"
}

variable "state_bucket" {}
variable "state_common_key" {}
