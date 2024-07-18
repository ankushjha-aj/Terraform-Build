variable "aws_instance_type" {
  description = "EC2 Instance type"
  type = string
  default = ""
}

variable "aws_ami" {
  description = "EC2 AMI id"
  type = string
  default = ""
}

variable "public_subnet_id" {
  type        = map(string)
  description = "Map of subnet IDs"
  default     = {}
}

variable "target_group_arn" {
  description = "ARN of the target group"
  type        = string
  default     = ""
}

variable "ec2_sg" {
  description = "Security group for EC2 instance"
  type        = string
  default     = ""
}

variable "vpc_id" {
  description = "The ID of vpc"
  type        = string
  default     = ""
}

variable "security_group_id" {
  description = "Security group id for the instance"
  type        = string
  default     = ""
  }
  
variable "attached_tags" {
  description = "Tags for the security group"
  type        = map(string)
  default     = {
    Name = "Ankush-attached-sg"
  }
}