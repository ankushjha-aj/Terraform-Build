variable "vpc_id" {
  description = "The ID of vpc"
  type        = string
  default     = ""
}

variable "igw_id" {
  description = "The ID of Internet Gateway"
  type        = string
  default     = ""
}

variable "public_subnet_id" {
  type        = map(string)
  description = "Map of subnet IDs"
  default     = {}
}

variable "private_subnet_id" {
  type        = map(string)
  description = "Map of subnet IDs"
  default     = {}
}

variable "nat_gateway_id" {
  description = "The ID of the NAT gateway for the private route table."
  type        = string
  default     = ""
}
