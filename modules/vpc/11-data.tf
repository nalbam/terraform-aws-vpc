# data

data "aws_availability_zones" "azs" {
}

data "aws_vpc" "this" {
  id = var.vpc_id == "" ? element(concat(aws_vpc.this.*.id, [""]), 0) : var.vpc_id
}

data "aws_internet_gateway" "this" {
  filter {
    name   = "attachment.vpc-id"
    values = [var.vpc_id == "" ? element(concat(aws_vpc.this.*.id, [""]), 0) : var.vpc_id]
  }
}
