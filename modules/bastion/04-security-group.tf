resource "aws_security_group" "vpc" {
  name        = "${var.name}-bastion-vpc"
  description = "Default security group that allows all instances in the VPC to talk to each other over any port and protocol."
  vpc_id      = "${data.aws_vpc.main.id}"

  ingress {
    from_port = "0"
    to_port   = "0"
    protocol  = "-1"
    self      = true
  }

  egress {
    from_port = "0"
    to_port   = "0"
    protocol  = "-1"
    self      = true
  }

  tags = {
    Name = "${var.name}-bastion-vpc"
  }
}

resource "aws_security_group" "egress" {
  name        = "${var.name}-bastion-egress"
  description = "Security group that allows egress to the internet for instances over HTTP and HTTPS."
  vpc_id      = "${data.aws_vpc.main.id}"

  // ALL
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.name}-bastion-egress"
  }
}

resource "aws_security_group" "ssh" {
  name        = "${var.name}-bastion-ssh"
  description = "Security group that allows ingress over SSH."
  vpc_id      = "${data.aws_vpc.main.id}"

  // SSH
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.name}-bastion-ssh"
  }
}
