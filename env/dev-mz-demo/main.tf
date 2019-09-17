# vpc

terraform {
  backend "s3" {
    region = "ap-northeast-2"
    bucket = "terraform-mz-seoul"
    key    = "vpc.tfstate"
  }
  required_version = ">= 0.12"
}

provider "aws" {
  region = var.region
}

module "vpc" {
  source = "../../modules/vpc"

  region = var.region
  name   = var.name

  vpc_id   = var.vpc_id
  vpc_cidr = var.vpc_cidr

  public_subnets  = var.public_subnets
  private_subnets = var.private_subnets

  tags = var.tags
}
