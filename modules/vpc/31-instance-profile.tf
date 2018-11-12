// instance profile for bastion

resource "aws_iam_role" "bastion" {
  name = "${var.city}-${var.stage}-${var.name}-BASTION"

  assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": "sts:AssumeRole",
            "Principal": {
                "Service": "ec2.amazonaws.com"
            },
            "Effect": "Allow",
            "Sid": ""
        }
    ]
}
EOF
}

// AdministratorAccess
resource "aws_iam_role_policy_attachment" "bastion" {
  role       = "${aws_iam_role.bastion.name}"
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

// Create a instance profile for the role.
resource "aws_iam_instance_profile" "bastion" {
  name = "${var.city}-${var.stage}-${var.name}-BASTION"
  role = "${aws_iam_role.bastion.name}"
}
