resource "aws_instance" "logstash" {
  ami                    = data.aws_ami.aws_ubuntu_image.id
  instance_type          = var.xxx
  subnet_id              = aws_subnet.xxx.id
  vpc_security_group_ids = [aws_security_group.xxx.id]
  key_name               = var.keypair_name


  tags = {
    Name = "challenge server"
  }

}

resource "aws_security_group" "logstash_sg" {
    name="logstash_sg"
    descritption= "SG for the Logtstash server"
    vpc_id = data.aws_vpc.xxx.id
}

#Inbound connection
ingress{
    description="beats port"
    from_port= 5503
    to_port=5503
    protocol="tcp"
    cidr_blocks=["0.0.0.0/0"]
}
    # 
  egress {
    description = "Allow access to the world"
    from_port   = 0
    to_port     = 0
    protocol    = "-1" # TCP + UDP
    cidr_blocks = ["0.0.0.0/0"]
  }



