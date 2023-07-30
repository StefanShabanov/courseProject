#Creating the AWS IAM Role and then we assume who can use the role (i.e. the EC2 VM we create)
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
# Here we create admin access policy and then connect the policy with the role we just created (line 25) so the role can have any permissions.
data "aws_iam_policy" "admin_access" {
  arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

resource "aws_iam_role_policy_attachment" "admin-role-policy-attach" {
  role       = aws_iam_role.role.name
  policy_arn = data.aws_iam_policy.admin_access.arn
}
# Creating the instance profile (including the Role and the permission policy in it ).
resource "aws_iam_instance_profile" "profile" {
  name = "k8s-profile-project"
  role = aws_iam_role.role.name
}