# Resource for creating VPC
resource "aws_vpc" "aws_test_vpc" {
  cidr_block = var.vpc_cidr_block
  # Enabling automatic hostname assigning
  # enable_dns_hostnames = true
  tags = {
    Name = "Ankush-vpc"
  }
}

resource "aws_vpc_dhcp_options" "domain" {
  domain_name         = var.domain_name
  domain_name_servers = var.domain_name_servers 

  tags = {
    Name = "Ankush-dhcp-options"
  }
}

resource "aws_vpc_dhcp_options_association" "this" {
  vpc_id          = aws_vpc.aws_test_vpc.id
  dhcp_options_id = aws_vpc_dhcp_options.domain.id
}