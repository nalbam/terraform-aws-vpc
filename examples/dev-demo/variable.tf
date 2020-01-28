# variable

variable "region" {
  default = "ap-northeast-2"
}

variable "name" {
  default = "seoul-dev-demo"
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
  default = true
}

variable "public_subnets" {
  default = [
    {
      zone = "ap-northeast-2a"
      cidr = "10.10.1.0/24"
      tags = {
        "kubernetes.io/cluster/seoul-dev-demo-eks-a" = "shared"
      }
    },
    {
      zone = "ap-northeast-2b"
      cidr = "10.10.2.0/24"
      tags = {
        "kubernetes.io/cluster/seoul-dev-demo-eks-b" = "shared"
      }
    },
    {
      zone = "ap-northeast-2c"
      cidr = "10.10.3.0/24"
      tags = {
        "kubernetes.io/cluster/seoul-dev-demo-eks-c" = "shared"
      }
    },
  ]
}

variable "private_subnets" {
  default = [
    {
      zone = "ap-northeast-2a"
      cidr = "10.10.4.0/24"
      tags = {}
    },
    {
      zone = "ap-northeast-2b"
      cidr = "10.10.5.0/24"
      tags = {}
    },
    {
      zone = "ap-northeast-2c"
      cidr = "10.10.6.0/24"
      tags = {}
    },
  ]
}

variable "tags" {
  default = {
    "kubernetes.io/cluster/seoul-dev-demo-eks" = "shared"
  }
}
