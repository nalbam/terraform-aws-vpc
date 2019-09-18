# subnet private

resource "aws_subnet" "private" {
  count = length(var.private_subnets)

  vpc_id = local.vpc_id

  availability_zone = var.private_subnets[count.index].zone

  cidr_block = var.private_subnets[count.index].cidr

  tags = merge(
    {
      Name = "${var.name}-private-${element(split("", var.private_subnets[count.index].zone), length(var.private_subnets[count.index].zone) - 1)}"
    },
    var.tags,
  )
}

resource "aws_eip" "private" {
  count = length(var.private_subnets) > 0 ? 1 : 0

  vpc        = true
  depends_on = [aws_route_table.public]

  tags = merge(
    {
      Name = "${var.name}-private"
    },
    var.tags,
  )
}

resource "aws_nat_gateway" "private" {
  count = length(var.private_subnets) > 0 ? 1 : 0

  allocation_id = aws_eip.private[count.index].id
  subnet_id     = aws_subnet.public[count.index].id

  tags = merge(
    {
      Name = "${var.name}-private"
    },
    var.tags,
  )
}

resource "aws_route_table" "private" {
  count = length(var.private_subnets) > 0 ? 1 : 0

  vpc_id = local.vpc_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.private[count.index].id
  }

  tags = merge(
    {
      Name = "${var.name}-private"
    },
    var.tags,
  )
}

resource "aws_route_table_association" "private" {
  count = length(var.private_subnets)

  route_table_id = aws_route_table.private[0].id
  subnet_id      = aws_subnet.private[count.index].id
}
