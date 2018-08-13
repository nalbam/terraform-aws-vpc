variable "region" {
  description = "The region to deploy the cluster in, e.g: us-east-1"
}

variable "name" {
  description = "Name of the cluster, e.g: demo"
}

variable "vpc_id" {
  description = "The VPC ID."
  default = ""
}

variable "vpc_cidr" {
  description = "The CIDR block for the VPC, e.g: 10.0.0.0/16"
  default = "10.0.0.0/16"
}

variable "key_name" {
  description = "The name of the key to user for ssh access, e.g: demo"
  default = "demo"
}

variable "public_key_path" {
  description = "The local public key path, e.g. ~/.ssh/id_rsa.pub"
  default = ""
}

variable "enable_eip" {
  default = false
}

variable "base_domain" {
  description = "Base domain of the bastion, e.g: nalbam.com"
  default = ""
}

data "aws_availability_zones" "azs" {}
