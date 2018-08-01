# bastion

module "bastion" {
  source   = "./modules/bastion"
  region   = "${var.region}"
  name     = "${var.name}"
  vpc_id   = "${var.vpc_id}"
  vpc_cidr = "${var.vpc_cidr}"
  key_name = "${var.key_name}"
}
