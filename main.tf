# bastion

module "bastion" {
  source          = "./modules/bastion"
  region          = "${var.region}"
  name            = "${var.name}"
  //vpc_id          = "vpc-0000000000"
  vpc_cidr        = "10.99.0.0/16"
  key_name        = "nalbam-seoul"
}
