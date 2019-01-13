# vpc

resource "aws_vpc" "default" {
  cidr_block = "${var.cidr_block}"

  enable_dns_hostnames = true

  tags = {
    Name = "${local.upper_name}"
  }
}

// Create an Internet Gateway.
resource "aws_internet_gateway" "default" {
  vpc_id = "${aws_vpc.default.id}"

  tags = {
    Name = "${local.upper_name}"
  }
}
