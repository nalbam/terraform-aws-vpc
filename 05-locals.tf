# locals

locals {
  vpc_id = var.create_vpc ? element(concat(aws_vpc.this.*.id, [""]), 0) : var.vpc_id

  gateway_id = var.create_vpc ? element(concat(aws_internet_gateway.this.*.id, [""]), 0) : element(concat(data.aws_internet_gateway.this.*.id, [""]), 0)

  max_subnet_count = max(
    length(var.public_subnets),
    length(var.private_subnets),
  )

  min_azs_count = min(
    length(data.aws_availability_zones.azs.names),
    3,
  )

  zone_count = local.max_subnet_count < 1 ? 0 : var.single_route_table ? 1 : local.min_azs_count
  zone_index = {
    "a" = 0,
    "b" = 1,
    "c" = 2,
  }

  nat_gateway_count = var.enable_nat_gateway ? var.single_nat_gateway ? 1 : length(var.public_subnets) : 0
}
