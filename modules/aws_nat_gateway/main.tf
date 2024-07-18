# Resource for creating aws elastic ip
resource "aws_eip" "eip_nat_gateway" {
  domain = "vpc"
  tags = {
    Name = "Ankush-eip"
  }
}

# Resource for creating aws nat gateway
resource "aws_nat_gateway" "aws_nat_gateway" {
  allocation_id = aws_eip.eip_nat_gateway.allocation_id
  subnet_id     = var.public_subnet_id["public_subnet_1"]

  tags = {
    Name = "Ankush-nat-gateway"
  }
}