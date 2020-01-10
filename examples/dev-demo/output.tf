# output

output "vpc_id" {
  value = module.vpc.vpc_id
}

output "public_subnet_ids" {
  value = module.vpc.public_subnet_ids
}

output "public_subnet_cidr" {
  value = module.vpc.public_subnet_cidr
}

output "public_subnet_azs" {
  value = module.vpc.public_subnet_azs
}

output "private_subnet_ids" {
  value = module.vpc.private_subnet_ids
}

output "private_subnet_cidr" {
  value = module.vpc.private_subnet_cidr
}

output "private_subnet_azs" {
  value = module.vpc.private_subnet_azs
}

output "nat_ip" {
  value = module.vpc.nat_ip
}
