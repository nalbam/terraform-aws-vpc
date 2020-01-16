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

output "public_route_table_ids" {
  value = aws_route_table.public.*.id
}

output "private_subnet_ids" {
  value = aws_subnet.private.*.id
}

output "private_subnet_cidr" {
  value = aws_subnet.private.*.cidr_block
}

output "private_route_table_ids" {
  value = aws_route_table.private.*.id
}

output "nat_gateway_ids" {
  value = aws_nat_gateway.private.*.id
}

output "nat_gateway_ips" {
  value = aws_eip.private.*.public_ip
}
