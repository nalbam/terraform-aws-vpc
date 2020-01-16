# route_table private

resource "aws_eip" "private" {
  count = local.nat_gateway_count

  vpc = true

  depends_on = [aws_route_table.public]

  tags = merge(
    {
      Name = format(
        "%s-private-%s",
        var.name,
        element(split("", data.aws_availability_zones.azs.names[count.index]), length(data.aws_availability_zones.azs.names[count.index]) - 1)
      )
    },
    var.tags,
  )
}

resource "aws_nat_gateway" "private" {
  count = local.nat_gateway_count

  allocation_id = aws_eip.private[count.index].id

  subnet_id = aws_subnet.public[count.index].id

  tags = merge(
    {
      Name = format(
        "%s-private-%s",
        var.name,
        element(split("", data.aws_availability_zones.azs.names[count.index]), length(data.aws_availability_zones.azs.names[count.index]) - 1)
      )
    },
    var.tags,
  )
}

resource "aws_route_table" "private" {
  count = local.nat_gateway_count

  vpc_id = local.vpc_id

  lifecycle {
    # When attaching VPN gateways it is common to define aws_vpn_gateway_route_propagation
    # resources that manipulate the attributes of the routing table (typically for the private subnets)
    ignore_changes = [propagating_vgws]
  }

  tags = merge(
    {
      Name = format(
        "%s-private-%s",
        var.name,
        element(split("", data.aws_availability_zones.azs.names[count.index]), length(data.aws_availability_zones.azs.names[count.index]) - 1)
      )
    },
    var.tags,
  )
}

resource "aws_route" "private" {
  count = local.nat_gateway_count

  route_table_id         = element(aws_route_table.private.*.id, count.index)
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = element(aws_nat_gateway.private.*.id, count.index)

  timeouts {
    create = "5m"
  }
}
