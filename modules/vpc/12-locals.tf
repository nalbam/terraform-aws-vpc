# locals

locals {
  name = "${var.stage}-${var.name}"

  full_name = "${var.city}-${var.stage}-${var.name}"

  upper_name = "${upper(local.full_name)}"

  lower_name = "${lower(local.full_name)}"

  az_names = "${data.aws_availability_zones.azs.names}"

  az_count = "${length(local.az_names) > 3 ? 3 : length(local.az_names)}"

  az_length = "${length(local.az_names[0])}"
}
