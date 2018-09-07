// Define the VPC.
resource "aws_vpc" "main" {
  count = "${var.vpc_id == "" ? 1 : 0}"

  cidr_block = "${var.vpc_cidr}"
  enable_dns_hostnames = true

  tags = {
    Name = "${var.name}-bastion"
  }
}

data "aws_vpc" "main" {
  id = "${var.vpc_id == "" ? aws_vpc.main.id : var.vpc_id}"
}

// Create a Subnet.
resource "aws_subnet" "bastion" {
  count = "${length(data.aws_availability_zones.azs.names)}"

  vpc_id = "${data.aws_vpc.main.id}"

  cidr_block = "${cidrsubnet(data.aws_vpc.main.cidr_block, 8, 31 + count.index)}"
  availability_zone = "${data.aws_availability_zones.azs.names[count.index]}"
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.name}-bastion-${element(split("", data.aws_availability_zones.azs.names[count.index]), length(data.aws_availability_zones.azs.names[count.index])-1)}"
  }
}

// Create an Internet Gateway.
resource "aws_internet_gateway" "bastion" {
  vpc_id = "${data.aws_vpc.main.id}"

  tags = {
    Name = "${var.name}-bastion"
  }
}

// Create a route table allowing all addresses access.
resource "aws_route_table" "bastion" {
  vpc_id = "${data.aws_vpc.main.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.bastion.id}"
  }

  tags = {
    Name = "${var.name}-bastion"
  }
}

// Now associate the route table with the bastion subnet
// - giving all bastion subnet instances access to the internet.
resource "aws_route_table_association" "bastion" {
  count = "${length(data.aws_availability_zones.azs.names)}"
  subnet_id = "${element(aws_subnet.bastion.*.id, count.index)}"
  route_table_id = "${aws_route_table.bastion.id}"
}
