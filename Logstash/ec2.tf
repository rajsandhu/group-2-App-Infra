resource "aws_instance" "challenge_server" {
  ami                    = data.aws_ami.aws_ubuntu_image.id
  instance_type          = var.xxx
  subnet_id              = aws_subnet.xxx.id
  vpc_security_group_ids = [aws_security_group.xxx.id]
  key_name               = var.keypair_name


  tags = {
    Name = "challenge server"
  }

}


