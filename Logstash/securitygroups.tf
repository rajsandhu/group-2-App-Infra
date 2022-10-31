resource "aws_security_group" "challenge_sg" {
    name="challenge_sg"
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


