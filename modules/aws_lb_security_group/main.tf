resource "aws_security_group" "lb_sg" {
  name        = var.lb_name 
  description = var.lb_description
  vpc_id      = var.vpc_id  

  ingress {
    description = "HTTP from ALB"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Change according to your needs, add your IP for testing 
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"] # Change according to your needs 
  }

  tags = var.lb_tags 
}