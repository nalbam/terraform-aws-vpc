# output

output "vpc_id" {
  value = local.vpc_id
}

output "public_subnet_ids" {
  value = aws_subnet.public.*.id
}

output "public_subnet_cidr" {
  value = aws_subnet.public.*.cidr_block
}

output "private_subnet_ids" {
  value = aws_subnet.private.*.id
}

output "private_subnet_cidr" {
  value = aws_subnet.private.*.cidr_block
}

output "nat_ip" {
  value = aws_eip.private.*.public_ip
}
