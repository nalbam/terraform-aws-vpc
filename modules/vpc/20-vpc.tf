# vpc

resource "aws_vpc" "default" {
  count = "${var.vpc_id == "" ? 1 : 0}"

  cidr_block = "${var.cidr_block}"

  enable_dns_hostnames = true

  tags = {
    Name = "${local.upper_name}-VPC"
  }
}

data "aws_vpc" "default" {
  id = "${var.vpc_id == "" ? element(concat(aws_vpc.default.*.id, list("")), 0) : var.vpc_id}"
}

// Create an Internet Gateway.
resource "aws_internet_gateway" "default" {
  count = "${var.vpc_id == "" ? 1 : 0}"

  vpc_id = "${data.aws_vpc.default.id}"

  tags = {
    Name = "${local.upper_name}-IGW"
  }
}

data "aws_internet_gateway" "default" {
  filter {
    name   = "attachment.vpc-id"
    values = ["${data.aws_vpc.default.id}"]
  }
}
