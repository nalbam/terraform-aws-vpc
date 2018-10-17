data "template_file" "setup" {
  template = "${file("${path.module}/files/setup.sh")}"
}

resource "aws_key_pair" "default" {
  count      = "${var.public_key_path != "" ? 1 : 0}"
  key_name   = "${var.key_name}"
  public_key = "${file(var.public_key_path)}"
}

resource "aws_instance" "default" {
  ami                     = "${data.aws_ami.default.id}"
  instance_type           = "${var.type}"
  subnet_id               = "${element(aws_subnet.default.*.id, 0)}"
  iam_instance_profile    = "${aws_iam_instance_profile.default.id}"
  user_data               = "${data.template_file.setup.rendered}"
  # disable_api_termination = true

  vpc_security_group_ids = [
    "${aws_security_group.vpc.id}",
    "${aws_security_group.egress.id}",
    "${aws_security_group.ingress.id}",
  ]

  key_name = "${var.key_name}"

  tags = {
    Name = "${var.city}-${upper(element(split("", data.aws_availability_zones.azs.names[0]), length(data.aws_availability_zones.azs.names[0])-1))}-${var.stage}-${var.name}-${var.suffix}"
  }
}

resource "aws_eip" "default" {
  instance = "${aws_instance.default.id}"
  vpc      = true

  tags = {
    Name = "${var.city}-${upper(element(split("", data.aws_availability_zones.azs.names[0]), length(data.aws_availability_zones.azs.names[0])-1))}-${var.stage}-${var.name}-${var.suffix}"
  }
}
