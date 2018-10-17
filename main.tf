# bastion

provider "aws" {
  region = "${var.region}"
}

terraform {
  backend "s3" {
    region = "ap-northeast-2"
    bucket = "terraform-nalbam-seoul"
    key = "bastion.tfstate"
  }
  required_version = "> 0.11.0"
}

module "bastion" {
  source      = "./modules/bastion"

  region      = "${var.region}"
  city        = "${var.city}"
  stage       = "${var.stage}"
  name        = "${var.name}"
  suffix      = "${var.suffix}"

  type        = "${var.type}"

  vpc_id      = "${var.vpc_id}"
  vpc_cidr    = "${var.vpc_cidr}"

  key_name    = "${var.key_name}"

  base_domain = "${var.base_domain}"
}

output "name" {
  value = "${module.bastion.name}"
}

output "domain" {
  value = "${module.bastion.domain}"
}

output "public_ip" {
  value = "${module.bastion.public_ip}"
}
