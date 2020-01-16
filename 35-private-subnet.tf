# subnet private

resource "aws_subnet" "private" {
  count = length(var.private_subnets)

  vpc_id = local.vpc_id

  availability_zone = var.private_subnets[count.index].zone

  cidr_block = var.private_subnets[count.index].cidr

  tags = merge(
    {
      Name = format(
        "%s-private-%s",
        var.name,
        element(split("", var.private_subnets[count.index].zone), length(var.private_subnets[count.index].zone) - 1)
      )
    },
    var.tags,
  )
}

resource "aws_route_table_association" "private" {
  count = local.nat_gateway_count > 0 ? length(var.private_subnets) : 0

  subnet_id = aws_subnet.private[count.index].id

  route_table_id = element(
    aws_route_table.private.*.id,
    var.single_nat_gateway ? 0 : local.zone_index[element(split("", var.private_subnets[count.index].zone), length(var.private_subnets[count.index].zone) - 1)]
  )
}
