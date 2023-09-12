# Creating the AWS IAM Role for Kubernetes and allowing EC2 instances to assume this role and use it.
resource "aws_iam_role" "role" {
  name               = "k8s-role-project"
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

# Creating an IAM Policy with AdministratorAccess and attaching it to the IAM Role created above.
data "aws_iam_policy" "admin_access" {
  arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

resource "aws_iam_role_policy_attachment" "admin-role-policy-attach" {
  role       = aws_iam_role.role.name
  policy_arn = data.aws_iam_policy.admin_access.arn
}

# Creating an IAM Instance Profile that includes the IAM Role with permissions.
resource "aws_iam_instance_profile" "profile" {
  name = "k8s-profile-project"
  role = aws_iam_role.role.name
}
