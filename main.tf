# bastion

module "bastion" {
  source          = "./modules/bastion"
  region          = "${var.region}"
  name            = "${var.name}"
  vpc_id          = "${var.vpc_id}"
  vpc_cidr        = "${var.vpc_cidr}"
  key_name        = "${var.key_name}"
  public_key_path = "${var.public_key_path}"
  base_domain     = "${var.base_domain}"
}
