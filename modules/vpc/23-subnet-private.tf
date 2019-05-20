# subnet private

resource "aws_subnet" "private" {
  count = "${var.private_subnet_enable ? local.az_count : 0}"

  vpc_id     = "${data.aws_vpc.this.id}"
  cidr_block = "${length(var.private_subnet_cidrs) > 0 ? var.private_subnet_cidrs[count.index] : cidrsubnet(data.aws_vpc.this.cidr_block, var.private_subnet_newbits, (count.index + var.private_subnet_netnum))}"

  availability_zone = "${local.az_names[count.index]}"

  tags = "${merge(map("Name", "${var.city}-${upper(element(split("", local.az_names[count.index]), (local.az_length - 1)))}-${local.name}-PRIVATE"), var.tags)}"
}

resource "aws_eip" "private" {
  count = "${var.private_subnet_enable ? local.az_count > 0 ? var.single_nat_gateway ? 1 : local.az_count : 0 : 0}"

  vpc        = true
  depends_on = ["aws_route_table.public"]

  tags = "${merge(map("Name", "${var.city}-${upper(element(split("", local.az_names[count.index]), (local.az_length - 1)))}-${local.name}-PRIVATE"), var.tags)}"
}

resource "aws_nat_gateway" "private" {
  count = "${var.private_subnet_enable ? local.az_count > 0 ? var.single_nat_gateway ? 1 : local.az_count : 0 : 0}"

  allocation_id = "${element(aws_eip.private.*.id, count.index)}"
  subnet_id     = "${element(aws_subnet.public.*.id, count.index)}"

  tags = "${merge(map("Name", "${var.city}-${upper(element(split("", local.az_names[count.index]), (local.az_length - 1)))}-${local.name}-PRIVATE"), var.tags)}"
}

resource "aws_route_table" "private" {
  count = "${var.private_subnet_enable ? local.az_count > 0 ? var.single_nat_gateway ? 1 : local.az_count : 0 : 0}"

  vpc_id = "${data.aws_vpc.this.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${element(aws_nat_gateway.private.*.id, count.index)}"
  }

  tags = "${merge(map("Name", "${var.city}-${upper(element(split("", local.az_names[count.index]), (local.az_length - 1)))}-${local.name}-PRIVATE"), var.tags)}"
}

resource "aws_route_table_association" "private" {
  count = "${var.private_subnet_enable ? local.az_count : 0}"

  route_table_id = "${element(aws_route_table.private.*.id, (var.single_nat_gateway ? 0 : count.index))}"
  subnet_id      = "${element(aws_subnet.private.*.id, count.index)}"
}
