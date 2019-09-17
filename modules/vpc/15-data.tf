# data

data "aws_vpc" "this" {
  id = local.vpc_id
}

data "aws_internet_gateway" "this" {
  filter {
    name   = "attachment.vpc-id"
    values = [local.vpc_id]
  }
}
