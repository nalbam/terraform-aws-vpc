# bastion

terraform {
  backend "s3" {
    region = "ap-northeast-2"
    bucket = "terraform-nalbam-seoul"
    key    = "vpc.tfstate"
  }

  required_version = "> 0.11.0"
}

provider "aws" {
  region = "${var.region}"
}

module "vpc" {
  source = "./modules/vpc"

  region = "${var.region}"
  city   = "${var.city}"
  stage  = "${var.stage}"
  name   = "${var.name}"

  vpc_id     = ""
  cidr_block = "10.10.0.0/16"

  instance_type = "t2.nano"
  key_path      = ""             # ~/.ssh/id_rsa.pub
  key_name      = "nalbam-seoul"
  base_domain   = "nalbam.com"
}

output "name" {
  value = "${module.vpc.name}"
}

output "vpc_id" {
  value = "${module.vpc.vpc_id}"
}

output "subnet_public_ids" {
  value = "${module.vpc.subnet_public_ids}"
}

output "subnet_private_ids" {
  value = "${module.vpc.subnet_private_ids}"
}

output "bastion_doamin" {
  value = "${module.vpc.bastion_doamin}"
}

output "bastion_ip" {
  value = "${module.vpc.bastion_ip}"
}
