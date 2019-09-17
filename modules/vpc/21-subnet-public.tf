# cluster subnet public

resource "aws_subnet" "public" {
  count = local.public_count

  vpc_id = data.aws_vpc.this.id

  cidr_block = var.public_subnet_cidrs[count.index]

  availability_zone = local.public_names[count.index]

  tags = merge(
    {
      Name = "${var.name}-public-${element(split("", local.public_names[count.index]), local.public_length - 1)}"
    },
    var.tags,
  )
}

resource "aws_route_table" "public" {
  count = local.public_count > 0 ? 1 : 0

  vpc_id = data.aws_vpc.this.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = data.aws_internet_gateway.this.id
  }

  tags = merge(
    {
      Name = "${var.name}-public"
    },
    var.tags,
  )
}

resource "aws_route_table_association" "public" {
  count = local.public_count

  route_table_id = aws_route_table.public[0].id
  subnet_id      = aws_subnet.public[count.index].id
}
