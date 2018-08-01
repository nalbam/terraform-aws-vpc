// Output some useful variables for quick SSH access etc.

output "public_dns" {
  value = "${aws_instance.bastion.public_dns}"
}

output "public_ip" {
  value = "${aws_instance.bastion.public_ip}"
}
