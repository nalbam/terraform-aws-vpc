# bastion

provider "aws" {
  region = "ap-northeast-2"
}

terraform {
  backend "s3" {
    region = "ap-northeast-2"
    bucket = "terraform-nalbam-seoul"
    key = "bastion.tfstate"
  }
}

module "bastion" {
  source          = "./modules/bastion"
  region          = "ap-northeast-2"
  name            = "demo"
  vpc_cidr        = "10.99.0.0/16"
  key_name        = "nalbam-seoul"
  base_domain     = "nalbam.com"
}

output "domain" {
  value = "${module.bastion.domain}"
}

output "public_ip" {
  value = "${module.bastion.public_ip}"
}
