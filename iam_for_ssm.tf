# Create new IAM role that will be assumed by the EC2 instances. 
# Make sure that the role has been converted to an instance-profile before being attached to an instance later. 
# The role will contain a policy that requires permissions to this role for SSM access.
# Repo: group-2-App-Infra
# The managed policy required is: AmazonSSMManagedInstanceCore

# Steps: 
# 1. Create IAM role, 
# 2. attach instance-profile 
# and 
# 3. AmazonSSMManagedInstanceCore policy to the role

resource "aws_iam_instance_profile" "dev-resources-iam-profile" {
  name = "instance-profile"
  role = aws_iam_role.dev-resources-iam-role.name
}

resource "aws_iam_role" "dev-resources-iam-role" {
  name        = "dev-ssm-role"
  description = "The role for the developer resources EC2"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
    }
  )
  tags = {
    stack = "test"
  }
}

resource "aws_iam_role_policy_attachment" "dev-resources-ssm-policy" {
  role       = aws_iam_role.dev-resources-iam-role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}