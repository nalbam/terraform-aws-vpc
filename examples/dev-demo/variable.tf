# variable

variable "region" {
  default = "ap-northeast-2"
}

variable "name" {
  default = "vpc-demo"
}

variable "vpc_id" {
  default = ""
}

variable "vpc_cidr" {
  default = "10.10.0.0/16"
}

variable "single_route_table" {
  default = false
}

variable "enable_nat_gateway" {
  default = true
}

variable "single_nat_gateway" {
  default = false
}

variable "public_subnets" {
  # type = list(object({
  #   zone = string
  #   cidr = string
  #   tags = map
  # }))
  default = [
    {
      name = "public-a"
      zone = "ap-northeast-2a"
      cidr = "10.10.1.0/24"
      tags = {}
    },
    {
      name = "public-b"
      zone = "ap-northeast-2b"
      cidr = "10.10.2.0/24"
      tags = {}
    },
    {
      name = "public-c"
      zone = "ap-northeast-2c"
      cidr = "10.10.3.0/24"
      tags = {}
    },
  ]
}

variable "private_subnets" {
  # type = list(object({
  #   zone = string
  #   cidr = string
  #   tags = map
  # }))
  default = [
    {
      name = "private-a"
      zone = "ap-northeast-2a"
      cidr = "10.10.4.0/24"
      tags = {}
    },
    {
      name = "private-b"
      zone = "ap-northeast-2b"
      cidr = "10.10.5.0/24"
      tags = {}
    },
    {
      name = "private-c"
      zone = "ap-northeast-2c"
      cidr = "10.10.6.0/24"
      tags = {}
    },
  ]
}

variable "tags" {
  description = "A map of tags to add to all resources"
  default = {
    "kubernetes.io/cluster/eks-demo" = "shared"
  }
}
