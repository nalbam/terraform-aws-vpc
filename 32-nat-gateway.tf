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
        element(split("", var.public_subnets[count.index].zone), length(var.public_subnets[count.index].zone) - 1)
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
        element(split("", var.public_subnets[count.index].zone), length(var.public_subnets[count.index].zone) - 1)
      )
    },
    var.tags,
  )
}
