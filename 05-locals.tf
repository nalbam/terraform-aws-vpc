# locals

locals {
  vpc_id = var.create_vpc ? element(concat(aws_vpc.this.*.id, [""]), 0) : var.vpc_id

  gateway_id = var.create_vpc ? element(concat(aws_internet_gateway.this.*.id, [""]), 0) : element(concat(data.aws_internet_gateway.this.*.id, [""]), 0)

  zone_count = var.single_route_table ? 1 : length(data.aws_availability_zones.azs.names) > 3 ? 3 : length(data.aws_availability_zones.azs.names)
  zone_index = {
    "a" = 0,
    "b" = 1,
    "c" = 2,
  }

  nat_gateway_count = var.enable_nat_gateway ? var.single_nat_gateway ? 1 : local.zone_count : 0
}
