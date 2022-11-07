data "aws_vpc" "main" {
  filter {
    name   = "tag:Name"
    values = [var.vpc_name]
  }
}

data "aws_subnet" "subnet_g_ls_e" {
  filter {
    name   = "tag:Name"
    values = [var.private_subnet_name]
  }
}

data "aws_ami" "aws_ubuntu_image" {
  owners      = [var.aws_ami_owner]
  most_recent = true
  filter {
    name   = "name"
    values = [var.aws_ami_name]
  }
}

resource "aws_ebs_volume" "ebs_logstash" {
  availability_zone = "eu-central-1a"
  size              = 50

  tags = {
    Name = "EBS"
  }
}

data "aws_subnet" "subnet_kibana" {
  filter {
    name   = "tag:Name"
    values = [var.public_subnet_name]
  }
}

data "aws_subnet" "subnet_g_beats"{
  filter {
    name   = "tag:Name"
    values = [var.demo_private_subnet_name]
  }
}