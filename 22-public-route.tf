# route_table public

resource "aws_route_table" "public" {
  count = length(var.public_subnets) > 0 ? 1 : 0

  vpc_id = local.vpc_id

  # route {
  #   cidr_block = "0.0.0.0/0"
  #   gateway_id = local.gateway_id
  # }

  tags = merge(
    {
      Name = "${var.name}-public"
    },
    var.tags,
  )
}

resource "aws_route" "public" {
  count = length(var.public_subnets) > 0 ? 1 : 0

  route_table_id         = aws_route_table.public[0].id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = local.gateway_id

  timeouts {
    create = "5m"
  }
}
