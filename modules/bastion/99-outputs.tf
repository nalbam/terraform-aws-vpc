// Output some useful variables for quick SSH access etc.

output "bastion-public_dns" {
  value = "${aws_instance.bastion.public_dns}"
}
output "bastion-public_ip" {
  value = "${aws_instance.bastion.public_ip}"
}
output "bastion-private_dns" {
  value = "${aws_instance.bastion.private_dns}"
}
output "bastion-private_ip" {
  value = "${aws_instance.bastion.private_ip}"
}
