# output

output "name" {
  value = "${local.full_name}"
}

output "vpc_id" {
  value = "${data.aws_vpc.default.id}"
}

output "subnet_public_ids" {
  value = "${aws_subnet.public.*.id}"
}

output "subnet_private_ids" {
  value = "${aws_subnet.private.*.id}"
}

output "bastion_doamin" {
  value = "${element(concat(aws_route53_record.bastion.*.name, list("")), 0)}"
}

output "bastion_ip" {
  value = "${element(concat(aws_eip.bastion.*.public_ip, list("")), 0)}"
}
