# cluster subnet public

resource "aws_subnet" "public" {
  count = "${var.public_subnet_enable ? local.az_count : 0}"

  vpc_id     = "${data.aws_vpc.this.id}"
  cidr_block = "${cidrsubnet(data.aws_vpc.this.cidr_block, var.public_subnet_newbits, (count.index + var.public_subnet_netnum))}"

  availability_zone = "${local.az_names[count.index]}"

  tags = "${merge(map("Name", "${var.city}-${upper(element(split("", local.az_names[count.index]), (local.az_length - 1)))}-${local.name}-PUBLIC"), var.tags)}"
}

resource "aws_route_table" "public" {
  count = "${var.public_subnet_enable ? local.az_count > 0 ? 1 : 0 : 0}"

  vpc_id = "${data.aws_vpc.this.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${var.vpc_id == "" ? aws_internet_gateway.this.*.id[0] : data.aws_internet_gateway.this.id}"
  }

  tags = "${merge(map("Name", "${local.full_name}-PUBLIC"), var.tags)}"
}

resource "aws_route_table_association" "public" {
  count = "${var.public_subnet_enable ? local.az_count : 0}"

  route_table_id = "${aws_route_table.public.*.id[0]}"
  subnet_id      = "${aws_subnet.public.*.id[count.index]}"
}
