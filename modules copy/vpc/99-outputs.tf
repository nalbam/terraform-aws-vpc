# output

output "vpc_id" {
  value = data.aws_vpc.this.id
}

output "vpc_cidr" {
  value = data.aws_vpc.this.cidr_block
}
