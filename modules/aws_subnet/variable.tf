variable "vpc_id" {
  type        = string
  description = "The ID of vpc"
  default     = ""
}

variable "public_subnet_conf" {
  type = map(object({
    name              = string
    cidr_block        = string
    availability_zone = string
  }))
  default = {}
}

variable "private_subnet_conf" {
  type = map(object({
    name              = string
    cidr_block        = string
    availability_zone = string
  }))
  default = {}
}
