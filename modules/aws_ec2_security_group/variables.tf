variable "ec2_description" {
  description = "The description of the security group"
  type        = string
}

variable "vpc_id" {
  description = "The VPC ID"
  type        = string
}

variable "ec2_name" {
  description = "The name of the EC2 instance"
  type        = string

}

variable "ec2_tags" {
  description = "Tags for the security group"
  type        = map(string)
  default     = {}
}