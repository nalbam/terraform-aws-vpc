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
resource "aws_iam_policy" "policy-forward-logs" {
  name        = "${var.name}-instance-forward-logs"
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
resource "aws_iam_policy_attachment" "attachment-forward-logs" {
  name       = "${var.name}-attachment-forward-logs"
  roles      = ["${aws_iam_role.instance-role.name}"]
  policy_arn = "${aws_iam_policy.policy-forward-logs.arn}"
}

// Create a instance profile for the role.
resource "aws_iam_instance_profile" "instance-profile" {
  name = "${var.name}-instance-profile"
  role = "${aws_iam_role.instance-role.name}"
}

// Create a user and access key for only permissions
resource "aws_iam_user" "aws-user" {
  name = "${var.name}-aws-user"
  path = "/"
}

// Policy taken from https://github.com/openshift/ansible-contrib/blob/9a6a546581983ee0236f621ae8984aa9dfea8b6e/reference-architecture/aws-ansible/playbooks/roles/cloudformation-infra/files/greenfield.json.j2#L844
resource "aws_iam_user_policy" "aws-user" {
  name = "${var.name}-aws-user-policy"
  user = "${aws_iam_user.aws-user.name}"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "ec2:CreateTags",
        "ec2:CreateVolume",
        "ec2:CreateSecurityGroup",
        "ec2:AttachVolume",
        "ec2:DetachVolume",
        "ec2:DeleteVolume",
        "ec2:DescribeInstance*",
        "ec2:DescribeVolume*",
        "ec2:DescribeSubnets",
        "ec2:DescribeSecurityGroups",
        "ec2:DescribeRouteTables",
        "ec2:AuthorizeSecurityGroupIngress",
        "elasticloadbalancing:ConfigureHealthCheck",
        "elasticloadbalancing:CreateLoadBalancer",
        "elasticloadbalancing:CreateLoadBalancerListeners",
        "elasticloadbalancing:DescribeLoadBalancers",
        "elasticloadbalancing:DescribeLoadBalancerAttributes",
        "elasticloadbalancing:DescribeTags",
        "elasticloadbalancing:DeleteLoadBalancer",
        "elasticloadbalancing:DeleteLoadBalancerListeners",
        "elasticloadbalancing:ModifyLoadBalancerAttributes",
        "elasticloadbalancing:RegisterInstancesWithLoadBalancer"
      ],
      "Resource": "*"
    }
  ]
}
EOF
}

resource "aws_iam_access_key" "aws-user" {
  user = "${aws_iam_user.aws-user.name}"
}
