variable "region" {
  description = "The region to deploy the cluster in, e.g: us-east-1"
}

variable "name" {
  description = "Name of the cluster, e.g: 'dev'. Useful when running multiple clusters in the same AWS account."
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
  description = "The name of the key to user for ssh access, e.g: dev"
  default = "dev"
}

data "aws_availability_zones" "azs" {}
