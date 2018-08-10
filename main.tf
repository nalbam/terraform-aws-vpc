# bastion

provider "aws" {
  region = "${var.region}"
}

terraform {
  backend "s3" {
    region = "${var.region}"
    bucket = "terraform-nalbam-seoul"
    key = "bastion.tfstate"
  }
}

module "bastion" {
  source      = "./modules/bastion"
  region      = "${var.region}"
  name        = "${var.name}"
  vpc_cidr    = "${var.vpc_cidr}"
  key_name    = "${var.key_name}"
  base_domain = "${var.base_domain}"
}

output "domain" {
  value = "${module.bastion.domain}"
}

output "public_ip" {
  value = "${module.bastion.public_ip}"
}
