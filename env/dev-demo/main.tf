# bastion

terraform {
  backend "s3" {
    region = "ap-northeast-2"
    bucket = "terraform-nalbam-seoul"
    key    = "vpc-demo.tfstate"
  }
  required_version = ">= 0.12"
}

provider "aws" {
  region = "ap-northeast-2"
}

module "vpc" {
  source = "../../modules2/vpc"

  region = "ap-northeast-2"
  city   = "seoul"
  stage  = "dev"
  name   = "demo"

  vpc_cidr = "10.10.0.0/16"

  tags = {
    "kubernetes.io/cluster/seoul-dev-demo-eks" = "shared"
    "kubernetes.io/cluster/seoul-dev-spot-eks" = "shared"
  }
}

module "subnets" {
  source = "../../modules2/subnets"

  region = "ap-northeast-2"
  city   = "seoul"
  stage  = "dev"
  name   = "demo"

  vpc_id = module.vpc.vpc_id

  public_subnet_enable  = true
  public_subnet_newbits = 8 # 8 0.0.0.0/24 1 C 256 255.255.255.000
  public_subnet_netnum  = 1 # (1,2,3)

  private_subnet_enable  = false
  private_subnet_newbits = 8 # 8 0.0.0.0/24 1 C 256 255.255.255.000
  private_subnet_netnum  = 4 # (4,5,6)

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
