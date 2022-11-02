data "aws_vpc" "main" {
    filter {
    name   = "tag:Name"
    values = [var.vpc_name]
  }
}

data "aws_subnet" "subnet_g_ls_e"{
  filter{
    name   = "tag:Name"
   values=[var.subnet_g_ls_e]
  }
}

data "aws_ami" "aws_ubuntu_image"{
  owners = [var.aws_ami_owner]
  most_recent = true
  filter {
    name="ubuntu"
    values =[var.ami_name]
  }
}

resource "aws_ebs_volume" "ebs_challenge" {
  availability_zone = "eu-central-1"
  size              = 50

  tags = {
    Name = "EBS"
  }

  
}


