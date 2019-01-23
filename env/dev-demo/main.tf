# bastion

terraform {
  backend "s3" {
    region = "ap-northeast-2"
    bucket = "terraform-nalbam-seoul"
    key    = "vpc.tfstate"
  }
}

provider "aws" {
  region = "ap-northeast-2"
}

module "vpc" {
  source = "../../modules/vpc"

  region = "ap-northeast-2"
  city   = "SEOUL"
  stage  = "DEV"
  name   = "DEMO"

  # vpc_id   = ""
  vpc_cidr = "10.10.0.0/16"

  public_subnet_enable  = true
  public_subnet_newbits = 4    // 0.0.0.0/20 16 C 4096 255.255.240.000
  public_subnet_netnum  = 0

  private_subnet_enable  = true
  private_subnet_newbits = 2    // 0.0.0.0/18 64 C 16384 255.255.192.000
  private_subnet_netnum  = 1

  single_nat_gateway = true
}

output "vpc_id" {
  value = "${module.vpc.vpc_id}"
}

output "vpc_cidr" {
  value = "${module.vpc.vpc_cidr}"
}

output "public_subnet_ids" {
  value = "${module.vpc.public_subnet_ids}"
}

output "public_subnet_cidr" {
  value = "${module.vpc.public_subnet_cidr}"
}

output "private_subnet_ids" {
  value = "${module.vpc.private_subnet_ids}"
}

output "private_subnet_cidr" {
  value = "${module.vpc.private_subnet_cidr}"
}

output "nat_ip" {
  value = "${module.vpc.nat_ip}"
}
