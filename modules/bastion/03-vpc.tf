// Define the VPC.
resource "aws_vpc" "main" {
  count = "${var.vpc_id == "" ? 1 : 0}"

  cidr_block = "${var.vpc_cidr}"
  enable_dns_hostnames = true

  tags = {
    Name = "${var.name} vpc"
  }
}

data "aws_vpc" "main" {
  id = "${var.vpc_id == "" ? aws_vpc.main.id : var.vpc_id}"
}

// Create a public subnet.
resource "aws_subnet" "public" {
  count = "${length(data.aws_availability_zones.azs.names)}"

  vpc_id = "${data.aws_vpc.main.id}"

  cidr_block = "${cidrsubnet(data.aws_vpc.main.cidr_block, 8, 31 + count.index)}"
  availability_zone = "${data.aws_availability_zones.azs.names[count.index]}"
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.name} public subnet"
  }
}

// Create an Internet Gateway for the VPC.
resource "aws_internet_gateway" "public" {
  vpc_id = "${data.aws_vpc.main.id}"

  tags = {
    Name = "${var.name} public internet gateway"
  }
}

// Create a route table allowing all addresses access to the NAT.
resource "aws_route_table" "public" {
  vpc_id = "${data.aws_vpc.main.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.public.id}"
  }

  tags = {
    Name = "${var.name} public route table"
  }
}

// Now associate the route table with the public subnet
// - giving all public subnet instances access to the internet.
resource "aws_route_table_association" "public" {
  count = "${length(data.aws_availability_zones.azs.names)}"
  subnet_id = "${element(aws_subnet.public.*.id, count.index)}"
  route_table_id = "${aws_route_table.public.id}"
}
