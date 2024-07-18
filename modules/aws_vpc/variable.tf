variable "vpc_cidr_block" {
  type        = string
  description = "cidr block for vpc"
}

variable "domain_name" {
  description = "Domain name for DHCP options"
  type        = string
  default = ""
}

variable "domain_name_servers" {
  description = "List of domain name servers"
  type        = list(string)
  default = [ "" ]
}