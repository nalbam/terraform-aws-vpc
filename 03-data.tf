# data

data "aws_internet_gateway" "this" {
  count = var.vpc_id != "" ? 1 : 0

  filter {
    name   = "attachment.vpc-id"
    values = [var.vpc_id]
  }
}
