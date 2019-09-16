# bastion

terraform {
  backend "s3" {
    region = "ap-northeast-2"
    bucket = "terraform-mz-seoul"
    key    = "vpc-spot.tfstate"
  }
  required_version = ">= 0.12"
}

provider "aws" {
  region = "ap-northeast-2"
}

module "vpc" {
  source = "../../modules/vpc"

  region = "ap-northeast-2"
  city   = "seoul"
  stage  = "dev"
  name   = "spot"

  vpc_id   = ""
  vpc_cidr = "10.11.0.0/16"

  public_subnet_enable = true
  public_subnet_zones = [
    "ap-northeast-2a",
    "ap-northeast-2b",
    "ap-northeast-2c",
  ]
  public_subnet_cidrs = [
    "10.11.1.0/24",
    "10.11.2.0/24",
    "10.11.3.0/24",
  ]

  private_subnet_enable = true
  private_subnet_zones = [
    "ap-northeast-2a",
    "ap-northeast-2b",
    "ap-northeast-2c",
  ]
  private_subnet_cidrs = [
    "10.11.4.0/24",
    "10.11.5.0/24",
    "10.11.6.0/24",
  ]

  single_nat_gateway = true

  tags = {
    "kubernetes.io/cluster/seoul-dev-spot-eks" = "shared"
  }
}

output "vpc_id" {
  value = module.vpc.vpc_id
}

output "vpc_cidr" {
  value = module.vpc.vpc_cidr
}

output "public_subnet_ids" {
  value = module.vpc.public_subnet_ids
}

output "public_subnet_cidr" {
  value = module.vpc.public_subnet_cidr
}

output "private_subnet_ids" {
  value = module.vpc.private_subnet_ids
}

output "private_subnet_cidr" {
  value = module.vpc.private_subnet_cidr
}

output "nat_ip" {
  value = module.vpc.nat_ip
}
