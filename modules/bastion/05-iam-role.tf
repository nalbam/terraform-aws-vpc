// Create a role which instances will assume.
// This role has a policy saying it can be assumed by ec2 instances.
resource "aws_iam_role" "bastion" {
  name = "${var.name}-bastion"

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
  name = "${var.name}-bastion"
  role = "${aws_iam_role.bastion.name}"
}
