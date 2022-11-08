resource "aws_instance" "elasticsearch" {
  ami                    = data.aws_ami.aws_ubuntu_image.id
  instance_type          = var.elasticsearch_instance_type
  subnet_id              = data.aws_subnet.subnet_g_ls_e.id
  vpc_security_group_ids = [aws_security_group.elasticsearch_sg.id]
  key_name               = var.keypair_name
  iam_instance_profile   = "instance-profile"

  tags = {
    Name = "elasticsearch server"
  }
}

resource "aws_ebs_volume" "ebs_elasticsearch" {
  availability_zone = "eu-central-1a"
  size              = 50
  tags = {
    Name = "EBS ElasticSearch"
  }
}

resource "aws_volume_attachment" "elasticsearch_ebs_attach" {
  device_name = "/dev/sdh"
  volume_id   = aws_ebs_volume.ebs_elasticsearch.id
  instance_id = aws_instance.elasticsearch.id
}

resource "aws_security_group" "elasticsearch_sg" {
  name        = "elasticsearch_sg"
  description = "SG for the ElasticSearch server"
  vpc_id      = data.aws_vpc.main.id


  #Inbound connection

  ingress {
    description = "Allow access to logstash"
    from_port   = 0
    to_port     = 0
    protocol    = "-1" # TCP + UDP
    security_groups = [aws_security_group.logstash_sg.id]
  }

  # outbound
  egress {
    description = "Allow access to the world"
    from_port   = 0
    to_port     = 0
    protocol    = "-1" # TCP + UDP
    cidr_blocks = ["0.0.0.0/0"]
  }

  #access to kibana
  egress {
    description = "ACCESS TO KIBANA"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
  security_groups = [aws_security_group.kibana_sg.id]
  }
}


