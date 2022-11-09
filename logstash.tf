resource "aws_instance" "logstash" {
  ami                    = data.aws_ami.aws_ubuntu_image.id
  instance_type          = var.logstash_instance_type
  subnet_id              = data.aws_subnet.subnet_g_ls_e.id
  vpc_security_group_ids = [aws_security_group.logstash_sg.id]
  key_name               = var.keypair_name
  iam_instance_profile   = "instance-profile"


  tags = {
    Name = "logstash server"
  }

}
resource "aws_volume_attachment" "logstash_ebs_attach" {
  device_name = "/dev/sdh"
  volume_id   = aws_ebs_volume.ebs_logstash.id
  instance_id = aws_instance.logstash.id
}
resource "aws_security_group" "logstash_sg" {
  name        = "logstash_sg"
  description = "SG for the Logtstash server"
  vpc_id      = data.aws_vpc.main.id


  #Inbound connection
  ingress {
    description = "beats port"
    from_port   = 5044
    to_port     = 5044
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "web api call"
    from_port   = 9600
    to_port     = 9700
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

  # egress {
  #   description = "Allow access to Elasticsearch"
  #   from_port   = 0
  #   to_port     = 0
  #   protocol    = "-1" # TCP + UDP
  #   security_groups =  [aws_security_group.elasticsearch_sg.id]
  # }

}
