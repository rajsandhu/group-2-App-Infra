resource "aws_instance" "elasticsearch" {
  ami                    = data.aws_ami.aws_ubuntu_image.id
  instance_type          = var.elasticsearch_instance_type
  subnet_id              = data.aws_subnet.subnet_g_ls_e.id
  vpc_security_group_ids = [aws_security_group.elasticsearch_sg.id]
  key_name               = var.keypair_name
  iam_instance_profile =  "instance-profile"


  tags = {
    Name = "elasticsearch server"
  }

}

resource "aws_security_group" "elasticsearch_sg" {
  name         = "elasticsearch_sg"
  description = "SG for the ElasticSearch server"
  vpc_id       = data.aws_vpc.main.id


  #Inbound connection
  ingress {
    description = "beats port"
    from_port   = 5503
    to_port     = 5503
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

  #access to kibana
}


