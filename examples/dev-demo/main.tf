# vpc

terraform {
  backend "s3" {
    region         = "ap-northeast-2"
    bucket         = "terraform-workshop-147748575754"
    key            = "vpc-demo.tfstate"
    dynamodb_table = "terraform-workshop-147748575754"
    encrypt        = true
  }
}

provider "aws" {
  region = var.region
}

module "vpc" {
  # source = "github.com/nalbam/terraform-aws-vpc?ref=v0.12.29"
  source = "../../"

  region = var.region
  name   = var.name

  vpc_id   = var.vpc_id
  vpc_cidr = var.vpc_cidr

  single_route_table = var.single_route_table

  enable_nat_gateway = var.enable_nat_gateway
  single_nat_gateway = var.single_nat_gateway

  public_subnets  = var.public_subnets
  private_subnets = var.private_subnets

  tags = var.tags
}
