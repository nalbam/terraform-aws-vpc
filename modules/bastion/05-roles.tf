// Create a role which instances will assume.
// This role has a policy saying it can be assumed by ec2 instances.
resource "aws_iam_role" "instance-role" {
  name = "${var.name}-instance-role"

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

// This policy allows an instance to forward logs to CloudWatch, and
// create the Log Stream or Log Group if it doesn't exist.
resource "aws_iam_policy" "forward-logs" {
  name        = "${var.name}-policy-forward-logs"
  path        = "/"
  description = "Allows an instance to forward logs to CloudWatch"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents",
        "logs:DescribeLogStreams"
      ],
      "Resource": [
        "arn:aws:logs:*:*:*"
      ]
    }
  ]
}
EOF
}

// Attach the policies to the roles.
resource "aws_iam_policy_attachment" "forward-logs" {
  name       = "${var.name}-attachment-forward-logs"
  roles      = ["${aws_iam_role.instance-role.name}"]
  policy_arn = "${aws_iam_policy.forward-logs.arn}"
}

// Poweruser
resource "aws_iam_role_policy_attachment" "poweruser" {
  role       = "${aws_iam_role.instance-role.name}"
  policy_arn = "arn:aws:iam::aws:policy/PowerUserAccess"
}

// Create a instance profile for the role.
resource "aws_iam_instance_profile" "instance-profile" {
  name = "${var.name}-instance-profile"
  role = "${aws_iam_role.instance-role.name}"
}
