variable region {
  default = "ap-northeast-2"
}

variable "name" {
  description = "Name of the bastion, e.g: demo"
  default = "demo"
}

variable "vpc_id" {
  description = "The ID for the VPC, e.g: vpc-0000000000"
  default = ""
}

variable "vpc_cidr" {
  description = "The CIDR block for the VPC, e.g: 10.0.0.0/16"
  default = "10.99.0.0/16"
}

variable "key_name" {
  description = "The name of the key to user for ssh access, e.g: demo"
  default = "nalbam-seoul"
}

variable "public_key_path" {
  description = "The local public key path, e.g. ~/.ssh/id_rsa.pub"
  default = ""
}

variable "base_domain" {
  description = "Base domain of the bastion, e.g: nalbam.com"
  default = "nalbam.com"
}
