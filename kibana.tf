resource "aws_instance" "kibana" {
  ami                    = data.aws_ami.aws_ubuntu_image.id
  instance_type          = var.kibana_instance_type
  subnet_id              = data.aws_subnet.subnet_kibana.id
  vpc_security_group_ids = [aws_security_group.kibana_sg.id]
  key_name               = var.keypair_name
  iam_instance_profile   = "instance-profile"
  tags = {
    Name = "kibana server"
  }
}

resource "aws_ebs_volume" "ebs_kibana" {
  availability_zone = "eu-central-1a"
  size              = 50
  tags = {
    Name = "EBS-kibana"
  }
}

resource "aws_volume_attachment" "kibana_ebs_attach" {
  device_name = "/dev/sdh"
  volume_id   = aws_ebs_volume.ebs_kibana.id
  instance_id = aws_instance.kibana.id
}

resource "aws_security_group" "kibana_sg" {
  name        = "kibana_sg"
  description = "SG for the Kibana server"
  vpc_id      = data.aws_vpc.main.id

  #Inbound connection
  ingress {
    description = "http"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  # 
  egress {
    description = "Allow access to the world"
    from_port   = 0
    to_port     = 0
    protocol    = "-1" # TCP + UDP
    cidr_blocks = ["0.0.0.0/0"]
  }


}
