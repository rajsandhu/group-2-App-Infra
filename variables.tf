variable "vpc_name" {
  description = "name of the vpc"
  type        = string
}

variable "logstash_instance_type" {
  description = "what is the ec2 type"
  type        = string
}

variable "private_subnet_name" {
  description = "name of the subnet"
}

variable "aws_ami_name" {
  description = "name of Ami"
  type        = string
}

variable "aws_ami_owner" {
  description = "the owner id of the ami"
  type        = string
}

variable "keypair_name" {
  type = string
}
