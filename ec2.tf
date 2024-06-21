resource "aws_security_group" "ssh_access" {
  name        = "allow_ssh_all_ipv4"
  description = "Allow SSH access from any IPv4 address"
  vpc_id      = aws_default_vpc.default_vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Allow all IPv4 addresses
  }

  ingress {
    from_port   = 3306  
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Allow MySQL/Aurora from anywhere
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Allow HTTP from anywhere
  }
    
  egress {  # Allow all outbound traffic
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

    tags = {
    Name = "docker-compose" # Name your Security group 
    }
}

resource "aws_key_pair" "deployer" {
  key_name   = "deployer_key" # Name Your Key_Pair
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC1eueNy7yturB4KoYZy6VaKJV8Mn5YI3rOWVREK9tZCRUVS/u2P9YRpHHjyZcJzu6Qu3dXIkyhEp8Epj8pe1kOQOv4FqH/OWbhxW9FWLdHQKaDA4rKEoLghioU6S08NOBWLJM6zrbzd55mqz8fB6gC53gLSXk/WaQwgAWrHKYl5ttbFrvLgnLLFoYs/epDH83AB/zvPI8+T3resoFe0LXxHZ03eGE+SQLTDjUOcbOInL2TfhH0Y+7Q79W+VfV6ZMVC38t8YM9ctp3kcBLyMBv4e0hKc31y1xatyPHWakSVtaIeU+Ts+M5cFomV8/pAAuHuvghbG1bfioMay0+IdPFf aws-docker-ec2"
  }

resource "aws_instance" "web_server" {
  ami           = "ami-04b70fa74e45c3917"
  key_name      = aws_key_pair.deployer.key_name   
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.ssh_access.id]

  tags = {
    Name = "ubuntu-docker" # Name Your EC2
    }
}

resource "aws_default_vpc" "default_vpc" {}
