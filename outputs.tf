output "bastion-public_dns" {
  value = "${module.bastion.public_dns}"
}

output "bastion-public_ip" {
  value = "${module.bastion.public_ip}"
}
