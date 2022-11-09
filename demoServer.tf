resource "aws_instance" "demo_server" {
  ami                    = data.aws_ami.aws_ubuntu_image.id
  instance_type          = var.demo_server_instance_type
  subnet_id              = data.aws_subnet.subnet_g_beats.id
  vpc_security_group_ids = [aws_security_group.demo_server_sg.id]
  key_name               = var.keypair_name
  iam_instance_profile   = "instance-profile"
  
  tags = {
    Name = "Demo server"
  }
}

resource "aws_ebs_volume" "ebs_demo_server" {
  availability_zone = "eu-central-1a"
  size              = 10
  tags = {
    Name = "EBS DemoServer"
  }
}

resource "aws_volume_attachment" "demo_server_ebs_attach" {
  device_name = "/dev/sdh"
  volume_id   = aws_ebs_volume.ebs_demo_server.id
  instance_id = aws_instance.demo_server.id
}

resource "aws_security_group" "demo_server_sg" {
  name        = "demo_server_sg"
  description = "SG for the Demo server"
  vpc_id      = data.aws_vpc.main.id


  # Outbound
  egress {
    description = "Allow access to logstash"
    from_port   = 5044
    to_port     = 5044
    protocol    = "-1" # TCP + UDP
    security_groups = [aws_security_group.logstash_sg.id]
  }
 }
