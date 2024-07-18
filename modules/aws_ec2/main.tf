resource "aws_security_group" "ec2_sg" {
  name        = "attached-sg" 
  description = "Attached- SG "
  vpc_id      = var.vpc_id

  ingress {
    description = "Allow SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

    egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = var.attached_tags 
}

# EC2 Instance
resource "aws_instance" "instance" {
  ami           = var.aws_ami
  instance_type = var.aws_instance_type 
  key_name      = aws_key_pair.my_key_pair.key_name
  subnet_id      = var.public_subnet_id["public_subnet_1"]
  security_groups = [aws_security_group.ec2_sg.id]   
  associate_public_ip_address = true  
  tags = {
    Name = "Ankush_EC2"
  }
}

resource "aws_key_pair" "my_key_pair" {
  key_name   = "Ankush_keypair"
  public_key = file("D:/Job and project/TERRAFORM - AWS - INFRA/my-key-pair.pub")
}

resource "aws_lb_target_group_attachment" "this" {
  target_group_arn = var.target_group_arn  
  target_id        = aws_instance.instance.id 
  port             = 80

  depends_on = [aws_instance.instance]
}