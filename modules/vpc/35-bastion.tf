# bastion

data "template_file" "bastion" {
  template = "${file("${path.module}/files/bastion.sh")}"

  vars {
    HOSTNAME = "${local.lower_name}"
  }
}

resource "aws_key_pair" "bastion" {
  count      = "${var.key_path != "" ? 1 : 0}"
  key_name   = "${local.upper_name}-BASTION"
  public_key = "${file(var.key_path)}"
}

resource "aws_instance" "bastion" {
  count                = "${var.instance_type != "" ? 1 : 0}"
  ami                  = "${data.aws_ami.amazon_linux.id}"
  instance_type        = "${var.instance_type}"
  subnet_id            = "${element(aws_subnet.public.*.id, 0)}"
  iam_instance_profile = "${aws_iam_instance_profile.bastion.id}"
  user_data            = "${data.template_file.bastion.rendered}"

  # disable_api_termination = true

  key_name = "${var.key_path != "" ? "${local.upper_name}-BASTION" : "${var.key_name}"}"
  vpc_security_group_ids = [
    "${aws_security_group.vpc.id}",
    "${aws_security_group.egress.id}",
    "${aws_security_group.ingress.id}",
  ]
  tags = {
    Name = "${var.city}-${upper(element(split("", data.aws_availability_zones.azs.names[0]), length(data.aws_availability_zones.azs.names[0])-1))}-${var.stage}-${var.name}-BASTION"
  }
}

resource "aws_eip" "bastion" {
  count    = "${var.instance_type != "" ? 1 : 0}"
  instance = "${aws_instance.bastion.id}"
  vpc      = true

  tags = {
    Name = "${var.city}-${upper(element(split("", data.aws_availability_zones.azs.names[0]), length(data.aws_availability_zones.azs.names[0])-1))}-${var.stage}-${var.name}-BASTION"
  }
}
