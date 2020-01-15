# locals

locals {
  vpc_id = var.create_vpc ? element(concat(aws_vpc.this.*.id, [""]), 0) : var.vpc_id

  gateway_id = var.create_vpc ? element(concat(aws_internet_gateway.this.*.id, [""]), 0) : element(concat(data.aws_internet_gateway.this.*.id, [""]), 0)

  nat_gateway_count = var.enable_nat_gateway ? var.single_nat_gateway ? 1 : length(var.public_subnets) : 0

  zone_index = {
    "a" = 0,
    "b" = 1,
    "c" = 2,
  }
}
