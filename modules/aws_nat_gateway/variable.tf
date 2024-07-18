variable "vpc_id" {
  description = "The ID of the VPC where the NAT gateway will be created."
  type        = string
  default     = ""
}

variable "public_subnet_id" {
  type        = map(string)
  description = "Map of subnet IDs"
  default     = {}
}
