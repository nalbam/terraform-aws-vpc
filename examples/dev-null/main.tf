# vpc

terraform {
  backend "s3" {
    region         = "ap-northeast-2"
    bucket         = "terraform-nalbam-seoul"
    key            = "vpc-null.tfstate"
    dynamodb_table = "terraform-nalbam-seoul"
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
}
