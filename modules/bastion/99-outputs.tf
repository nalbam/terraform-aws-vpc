// Output some useful variables for quick SSH access etc.

output "name" {
  value = "${var.city}-${var.stage}-${var.name}-${var.suffix}"
}

output "domain" {
  value = "${aws_route53_record.default.*.name}"
}

output "public_ip" {
  value = "${aws_eip.default.public_ip}"
}
