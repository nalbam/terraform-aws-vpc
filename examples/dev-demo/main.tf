# vpc

terraform {
  backend "s3" {
    region         = "ap-northeast-2"
    bucket         = "terraform-mz-seoul"
    key            = "vpc-demo.tfstate"
    dynamodb_table = "terraform-mz-seoul"
    encrypt        = true
  }
  required_version = ">= 0.12"
}

provider "aws" {
  region = var.region
}

module "vpc" {
  source = "../.."

  region = var.region
  name   = var.name

  vpc_id   = var.vpc_id
  vpc_cidr = var.vpc_cidr

  enable_nat_gateway = var.enable_nat_gateway
  single_nat_gateway = var.single_nat_gateway

  public_subnets  = var.public_subnets
  private_subnets = var.private_subnets

  tags = var.tags
}
