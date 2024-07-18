# AWS Region
variable "region" {
  description = "The AWS region to create resources in"
  type        = string
  default     = "us-east-1" # Change according to your needs
}

# VPC Configuration
variable "vpc_cidr_block" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "domain_name" {
  description = "Domain name for DHCP options"
  type        = string
  default     = "example.com" // Replace with your domain
}

variable "domain_name_servers" {
  description = "List of domain name servers"
  type        = list(string)
  default     = ["10.0.0.2"] // Replace with your DNS servers
}

# Subnet Configuration
variable "public_subnet_conf" {
  type = map(object({
    name              = string
    cidr_block        = string
    availability_zone = string
  }))
  default = {
    public_subnet_1 = {
      name              = "public_subnet_1"
      cidr_block        = "10.0.1.0/24"
      availability_zone = "us-east-1a" # Change according to your needs
    },
    public_subnet_2 = {
      name              = "public_subnet_2"
      cidr_block        = "10.0.2.0/24"
      availability_zone = "us-east-1b" # Change according to your needs
    },
    public_subnet_3 = {
      name              = "public_subnet_3"
      cidr_block        = "10.0.3.0/24"
      availability_zone = "us-east-1c" # Change according to your needs
    }
  }
}

variable "private_subnet_conf" {
  type = map(object({
    name              = string
    cidr_block        = string
    availability_zone = string
  }))
  default = {
    private_subnet_1 = {
      name              = "private_subnet_1"
      cidr_block        = "10.0.101.0/24"
      availability_zone = "us-east-1a" # Change according to your needs
    },
    private_subnet_2 = {
      name              = "private_subnet_2"
      cidr_block        = "10.0.102.0/24"
      availability_zone = "us-east-1b" # Change according to your needs
    },
    private_subnet_3 = {
      name              = "private_subnet_3"
      cidr_block        = "10.0.103.0/24"
      availability_zone = "us-east-1c" # Change according to your needs
    }
  }
}

# EC2 Instance Configuration (Optional)
variable "aws_ami" {
  description = "EC2 AMI ID"
  type        = string
  default     = "ami-0b2a9065573b0a9c9" // Replace with your desired AMI 
  # If you have AWS CLI installed you can list for ubuntu AMI from: 
  # aws ec2 describe-images --owners 099720109477 --filters "Name=name,Values=ubuntu/images/hvm-ssd/*" "Name=state,Values=available" --query "Images[*].[ImageId,Name]" --output text
}

variable "aws_instance_type" {
  description = "EC2 Instance type"
  type        = string
  default     = "t2.micro" # Change according to your needs
}

variable "bucket_name" {
  description = "The name of the S3 bucket"
  type        = string
  default     = "cruddy-chancellor-1" # Change according to your needs
}

variable "target_group_name" {
  description = "Name of the target group"
  type        = string
  default     = "my-target-group" # Change according to your needs
}

variable "target_group_port" {
  description = "Port for the target group"
  type        = number
  default     = 80
}

variable "target_group_protocol" {
  description = "Protocol for the target group"
  type        = string
  default     = "HTTP"
}

variable "healthy_threshold" {
  description = "Healthy threshold for target group"
  type        = number
  default     = 3
}

variable "unhealthy_threshold" {
  description = "Unhealthy threshold for target group"
  type        = number
  default     = 3
}

variable "timeout" {
  description = "Timeout for target group"
  type        = number
  default     = 5
}

variable "interval" {
  description = "Interval for target group health checks"
  type        = number
  default     = 30
}

variable "path" {
  description = "Path for target group health checks"
  type        = string
  default     = "/"
}


variable "lb_name" {
  description = "The name of the security group"
  type        = string
  default     = "Ankush-lb-sg" # Change according to your needs
}

variable "lb_security_group_description" {
  description = "The description of the security group"
  type        = string
  default     = "Security group for load balancer"
}

variable "lb_tags" {
  description = "Tags to apply to the resources"
  type        = map(string)
  default = {
    Name = "Ankush-lb-sg" # Change according to your needs
  }
}

# This is created for another security group which we can add later on if we want to add more security to our SG

variable "ec2_name" {
  description = "The name of the EC2 instance"
  type        = string
  default     = "Ankush-ec2-sg" # Change according to your needs

}

variable "ec2_security_group_description" {
  description = "The description of the security group"
  type        = string
  default     = "Security group for ec2_instance" 
}

variable "ec2_tags" {
  description = "Tags to apply to the resources"
  type        = map(string)
  default = {
    Name = "Ankush-ec2-sg" # Change according to your needs 
  }
}


