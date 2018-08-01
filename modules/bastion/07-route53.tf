data "aws_route53_zone" "bastion" {
  count = "${var.base_domain != "" ? 1 : 0}"
  name  = "${var.base_domain}"
}

resource "aws_route53_record" "bastion" {
  count   = "${var.base_domain != "" ? 1 : 0}"
  zone_id = "${data.aws_route53_zone.bastion.zone_id}"
  name    = "${var.name}-bastion.${data.aws_route53_zone.bastion.name}"
  type    = "A"
  ttl     = 300
  records = [
      "${aws_eip.bastion.public_ip}"
  ]
}
