# subnet private

resource "aws_subnet" "private" {
  count = local.private_count

  vpc_id = data.aws_vpc.this.id

  cidr_block = var.private_subnet_cidrs[count.index]

  availability_zone = local.private_names[count.index]

  tags = merge(
    {
      Name = "${var.name}-private-${element(split("", local.public_names[count.index]), local.public_length - 1)}"
    },
    var.tags,
  )
}

resource "aws_eip" "private" {
  count = local.private_count > 0 ? var.single_nat_gateway ? 1 : local.private_count : 0

  vpc        = true
  depends_on = [aws_route_table.public]

  tags = merge(
    {
      Name = "${var.name}-private-${element(split("", local.public_names[count.index]), local.public_length - 1)}"
    },
    var.tags,
  )
}

resource "aws_nat_gateway" "private" {
  count = local.private_count > 0 ? var.single_nat_gateway ? 1 : local.private_count : 0

  allocation_id = element(aws_eip.private.*.id, count.index)
  subnet_id     = element(aws_subnet.public.*.id, count.index)

  tags = merge(
    {
      Name = "${var.name}-private-${element(split("", local.public_names[count.index]), local.public_length - 1)}"
    },
    var.tags,
  )
}

resource "aws_route_table" "private" {
  count = local.private_count > 0 ? var.single_nat_gateway ? 1 : local.private_count : 0

  vpc_id = data.aws_vpc.this.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = element(aws_nat_gateway.private.*.id, count.index)
  }

  tags = merge(
    {
      Name = "${var.name}-private-${element(split("", local.public_names[count.index]), local.public_length - 1)}"
    },
    var.tags,
  )
}

resource "aws_route_table_association" "private" {
  count = local.private_count

  route_table_id = element(
    aws_route_table.private.*.id,
    var.single_nat_gateway ? 0 : count.index,
  )
  subnet_id = element(aws_subnet.private.*.id, count.index)
}
