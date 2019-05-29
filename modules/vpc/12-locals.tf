# locals

locals {
  name = "${var.stage}-${var.name}"

  full_name = "${var.city}-${var.stage}-${var.name}"

  upper_name = "${upper(local.full_name)}"

  lower_name = "${lower(local.full_name)}"

  az_names = "${data.aws_availability_zones.azs.names}"

  public_count = "${var.public_subnet_enable ? var.public_subnet_count > 0 ? var.public_subnet_count : length(local.az_names) > 3 ? 3 : length(local.az_names) : 0}"

  private_count = "${var.private_subnet_enable ? var.private_subnet_count > 0 ? var.private_subnet_count : length(local.az_names) > 3 ? 3 : length(local.az_names) : 0}"

  az_length = "${length(local.az_names[0])}"
}
