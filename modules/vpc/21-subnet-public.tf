# cluster subnet public

resource "aws_subnet" "public" {
  count = length(var.public_subnets)

  vpc_id = data.aws_vpc.this.id

  availability_zone = var.public_subnets[count.index].zone

  cidr_block = var.public_subnets[count.index].cidr

  tags = merge(
    {
      Name = "${var.name}-public-${element(split("", var.public_subnets[count.index].zone), length(var.public_subnets[count.index].zone) - 1)}"
    },
    var.tags,
  )
}

resource "aws_route_table" "public" {
  count = length(var.public_subnets) > 0 ? 1 : 0

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
  count = length(var.public_subnets)

  route_table_id = aws_route_table.public[0].id
  subnet_id      = aws_subnet.public[count.index].id
}
