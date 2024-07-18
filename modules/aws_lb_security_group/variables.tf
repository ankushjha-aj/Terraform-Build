variable "lb_name" {
  description = "The name of the security group"
  type        = string
}

variable "lb_description" {
  description = "The description of the security group"
  type        = string
}

variable "vpc_id" {
  description = "The VPC ID"
  type        = string
}

variable "lb_tags" {
  description = "Tags for the security group"
  type        = map(string)
  default     = {}
}
