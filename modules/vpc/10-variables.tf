# variable

variable "region" {
  description = "The region to deploy the cluster in, e.g: us-east-1"
}

variable "city" {
  description = "City Name of the cluster, e.g: VIRGINIA"
}

variable "stage" {
  description = "Stage Name of the cluster, e.g: DEV"
}

variable "name" {
  description = "Name of the cluster, e.g: DEMO"
}

variable "suffix" {
  description = "Name of the cluster, e.g: BASTION"
}

variable "vpc_id" {
  description = "The VPC ID."
  default     = ""
}

variable "cidr_block" {
  description = "The CIDR block for the VPC, e.g: 10.0.0.0/16"
  default     = "10.0.0.0/16"
}

variable "topology" {
  description = "The topology for the VPC, e.g: public"
  default     = "public"
}

variable "instance_type" {
  description = "Type of the bastion instance, e.g: t2.micro"
  default     = ""
}

variable "key_name" {
  description = "The name of the key to user for ssh access, e.g: demo"
  default     = ""
}

variable "key_path" {
  description = "The local public key path, e.g. ~/.ssh/id_rsa.pub"
  default     = ""
}

variable "base_domain" {
  description = "Base domain for bastion, e.g: nalbam.com"
  default     = ""
}

data "aws_availability_zones" "azs" {}
