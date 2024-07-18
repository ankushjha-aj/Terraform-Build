resource "aws_security_group" "ec2_sg" { # This Sg will attached to this istance 
  name        = "attached-sg" 
  description = "Attached- SG "
  vpc_id      = var.vpc_id

  ingress {
    description = "Allow SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Change according to your needs
  }

    egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"] # Change according to your needs 
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
    Name = "Ankush_EC2" # Change according to your needs and you can also call it via var.name but you need to add that parameter also 
  }
}

resource "aws_key_pair" "my_key_pair" {
  key_name   = "Ankush_keypair"
  public_key = file("D:/Job and project/TERRAFORM - AWS - INFRA/my-key-pair.pub") # The SSH-key File that will be attached to your instance for Security purpose and SSH Connection
}

resource "aws_lb_target_group_attachment" "this" {  # This resource will attach tyhe newly created EC2 in target Group fpr port 80 further details you can find it in target_group module
  target_group_arn = var.target_group_arn  
  target_id        = aws_instance.instance.id 
  port             = 80

  depends_on = [aws_instance.instance]
}