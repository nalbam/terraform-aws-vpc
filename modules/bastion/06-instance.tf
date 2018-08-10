data "template_file" "setup" {
  template = "${file("${path.module}/files/setup.sh")}"
}

resource "aws_key_pair" "bastion" {
  count      = "${var.public_key_path != "" ? 1 : 0}"
  key_name   = "${var.key_name}"
  public_key = "${file(var.public_key_path)}"
}

resource "aws_instance" "bastion" {
  ami                     = "${data.aws_ami.default.id}"
  instance_type           = "t2.micro"
  subnet_id               = "${element(aws_subnet.public.*.id, 0)}"
  iam_instance_profile    = "${aws_iam_instance_profile.bastion.id}"
  user_data               = "${data.template_file.setup.rendered}"
  disable_api_termination = true

  vpc_security_group_ids = [
    "${aws_security_group.vpc.id}",
    "${aws_security_group.ssh.id}",
    "${aws_security_group.public-egress.id}",
  ]

  key_name = "${var.key_name}"

  tags = {
    Name = "${var.name}-bastion"
  }
}

resource "aws_eip" "bastion" {
  instance = "${aws_instance.bastion.id}"
  vpc = true

  tags = {
    Name = "${var.name}-bastion"
  }
}
