# locals

locals {
  common_tags = {
    "kubernetes.io/cluster/eks-demo" = "shared"
  }

  public_subnets = [
    {
      name = "${var.name}-public-a"
      zone = "ap-northeast-2a"
      cidr = "10.10.1.0/24"
      tags = {}
    },
    {
      name = "${var.name}-public-b"
      zone = "ap-northeast-2b"
      cidr = "10.10.2.0/24"
      tags = {}
    },
    {
      name = "${var.name}-public-c"
      zone = "ap-northeast-2c"
      cidr = "10.10.3.0/24"
      tags = {}
    },
  ]

  private_subnets = [
    {
      name = "${var.name}-private-a"
      zone = "ap-northeast-2a"
      cidr = "10.10.4.0/24"
      tags = {}
    },
    {
      name = "${var.name}-private-b"
      zone = "ap-northeast-2b"
      cidr = "10.10.5.0/24"
      tags = {}
    },
    {
      name = "${var.name}-private-c"
      zone = "ap-northeast-2c"
      cidr = "10.10.6.0/24"
      tags = {}
    },
  ]
}
