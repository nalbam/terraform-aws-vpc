# locals

locals {
  name = "${var.stage}-${var.name}"

  full_name = "${var.city}-${var.stage}-${var.name}"

  az_names = data.aws_availability_zones.azs.names

  az_length = length(local.az_names[0])

  public_count = var.public_subnet_enable ? length(var.public_subnet_zones) > 0 ? length(var.public_subnet_zones) : length(local.az_names) > 3 ? 3 : length(local.az_names) : 0

  public_names = length(var.public_subnet_zones) > 0 ? var.public_subnet_zones : data.aws_availability_zones.azs.names

  public_length = length(var.public_subnet_zones) > 0 ? length(var.public_subnet_zones[0]) : length(data.aws_availability_zones.azs.names[0])

  private_count = var.private_subnet_enable ? length(var.private_subnet_zones) > 0 ? length(var.private_subnet_zones) : length(local.az_names) > 3 ? 3 : length(local.az_names) : 0

  private_names = length(var.private_subnet_zones) > 0 ? var.private_subnet_zones : data.aws_availability_zones.azs.names

  private_length = length(var.private_subnet_zones) > 0 ? length(var.private_subnet_zones[0]) : length(data.aws_availability_zones.azs.names[0])
}
