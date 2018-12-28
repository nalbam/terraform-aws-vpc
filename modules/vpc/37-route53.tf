# route53

data "aws_route53_zone" "default" {
  count = "${var.base_domain != "" ? 1 : 0}"
  name  = "${var.base_domain}"
}

resource "aws_route53_record" "bastion" {
  count   = "${element(concat(aws_eip.bastion.*.public_ip, list("")), 0) != "" ? 1 : 0}"
  zone_id = "${data.aws_route53_zone.default.zone_id}"
  name    = "${local.lower_name}-bastion.${data.aws_route53_zone.default.name}"
  type    = "A"
  ttl     = 300

  records = [
    "${aws_eip.bastion.public_ip}",
  ]
}
