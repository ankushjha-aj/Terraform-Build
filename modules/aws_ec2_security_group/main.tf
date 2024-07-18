resource "aws_security_group" "ec2" {
  name        = var.ec2_name
  description = var.ec2_description  
  vpc_id      = var.vpc_id  

  ingress {
    description = "To allow SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Change according to your needs, Add Your IPAddress For this For Security Purpose
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"] # Change according to your needs
  }

  ingress {
    description = "To allow HTTP "
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Change according to your needs
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"] # Change according to your needs
  }


  tags = {
    Name = "Ec2-sg"
  }
}