// Output some useful variables for quick SSH access etc.

output "domain" {
  value = "${aws_route53_record.bastion.*.name}"
}

output "public_ip" {
  value = "${aws_instance.bastion.public_ip}"
}
