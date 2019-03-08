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
  public_subnet_newbits = 8    # 8 0.0.0.0/24 1 C 256 255.255.255.000
  public_subnet_netnum  = 1

  private_subnet_enable  = false
  private_subnet_newbits = 8     # 8 0.0.0.0/24 1 C 256 255.255.255.000
  private_subnet_netnum  = 3

  single_nat_gateway = true

  tags = "${
    map(
     "kubernetes.io/cluster/seoul-dev-demo-eks", "shared",
     "kubernetes.io/cluster/seoul-dev-spot-eks", "shared",
    )
  }"
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
