
resource "aws_security_group" "pub-ec2-sg" {
  name        = var.pubsecgrp
  description = var.pubsecgrp
  vpc_id      = var.vpc

  ingress {
    from_port   = 22
    protocol    = "tcp"
    to_port     = 22
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 3306
    protocol    = "tcp"
    to_port     = 3306
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "Public_ec2" {
  ami                         = var.instance_ami
  instance_type               = var.bastion_instance_type
  key_name                    = var.key_name
  subnet_id                   = var.public_subnet_id
  associate_public_ip_address = true

  vpc_security_group_ids = [
    aws_security_group.pub-ec2-sg.id
  ]

  tags = {
    Name        = var.pub_instance_name
    Environment = "UAT"
    OS          = "UBUNTU"
  }

  depends_on = [aws_security_group.pub-ec2-sg]

}

