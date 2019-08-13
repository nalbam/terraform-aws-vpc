# bastion

terraform {
  backend "s3" {
    region = "ap-northeast-2"
    bucket = "terraform-nalbam-seoul"
    key    = "vpc-cidr.tfstate"
  }
  required_version = ">= 0.12"
}

provider "aws" {
  region = "ap-northeast-2"
}

module "subnets" {
  source = "../../modules2/subnets"

  region = "ap-northeast-2"
  city   = "seoul"
  stage  = "dev"
  name   = "cidr"

  vpc_id = "vpc-0c9895df8f7fdff1e"

  public_subnet_enable = true
  public_subnet_count = 2
  public_subnet_zones = [
    "ap-northeast-2a",
    "ap-northeast-2b",
    "ap-northeast-2c",
  ]
  public_subnet_cidrs = [
    "10.10.11.0/24",
    "10.10.12.0/24",
    "10.10.13.0/24",
  ]

  private_subnet_enable = false
  private_subnet_count = 2
  private_subnet_zones = [
    "ap-northeast-2a",
    "ap-northeast-2b",
    "ap-northeast-2c",
  ]
  private_subnet_cidrs = [
    "10.10.14.0/24",
    "10.10.15.0/24",
    "10.10.16.0/24",
  ]

  single_nat_gateway = true

  tags = module.vpc.tags
}

output "vpc_id" {
  value = module.vpc.vpc_id
}

output "vpc_cidr" {
  value = module.vpc.vpc_cidr
}

output "public_subnet_ids" {
  value = module.subnets.public_subnet_ids
}

output "public_subnet_cidr" {
  value = module.subnets.public_subnet_cidr
}

output "private_subnet_ids" {
  value = module.subnets.private_subnet_ids
}

output "private_subnet_cidr" {
  value = module.subnets.private_subnet_cidr
}

output "nat_ip" {
  value = module.subnets.nat_ip
}
