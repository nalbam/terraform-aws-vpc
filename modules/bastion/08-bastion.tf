data "template_file" "setup" {
  template = "${file("${path.module}/files/setup.sh")}"
}

resource "aws_instance" "bastion" {
  ami                  = "${data.aws_ami.default.id}"
  instance_type        = "t2.micro"
  subnet_id            = "${element(aws_subnet.public.*.id, 0)}"
  iam_instance_profile = "${aws_iam_instance_profile.instance-profile.id}"
  user_data            = "${data.template_file.setup.rendered}"

  vpc_security_group_ids = [
    "${aws_security_group.vpc.id}",
    "${aws_security_group.ssh.id}",
    "${aws_security_group.public-egress.id}",
  ]

  key_name = "${var.key_name}"

  tags = {
     Name = "${var.name} bastion"
  }
}

resource "aws_eip" "bastion" {
  instance = "${aws_instance.bastion.id}"
  vpc = true

  tags = {
     Name = "${var.name} bastion"
  }
}
