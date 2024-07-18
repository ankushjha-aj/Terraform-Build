# Creating an Route Table for the public subnet!
resource "aws_route_table" "public_route_table" {
  vpc_id = var.vpc_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = var.igw_id
  }

  tags = {
    Name = "Ankush-ig-rt"
  }
}

# Creating a Route Table for the Nat Gateway!
resource "aws_route_table" "NAT-Gateway-RT" {
  vpc_id = var.vpc_id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = var.nat_gateway_id
  }

  tags = {
    Name = "Ankush-nat-rt"
  }

}

# Associate Public Subnet 1 with Public Route Table
resource "aws_route_table_association" "public_subnet_1_association" {
  subnet_id      = var.public_subnet_id["public_subnet_1"]
  route_table_id = aws_route_table.public_route_table.id
}

# Associate Public Subnet 2 with Public Route Table
resource "aws_route_table_association" "public_subnet_2_association" {
  subnet_id      = var.public_subnet_id["public_subnet_2"]
  route_table_id = aws_route_table.public_route_table.id
}

# Associate Public Subnet 3 with Public Route Table
resource "aws_route_table_association" "public_subnet_3_association" {
  subnet_id      = var.public_subnet_id["public_subnet_3"]
  route_table_id = aws_route_table.public_route_table.id
}

# Associate Private Subnet 1 with NAT Gateway Route Table
resource "aws_route_table_association" "nat_gateway_route_table_association" {
  subnet_id      = var.private_subnet_id["private_subnet_1"]
  route_table_id = aws_route_table.NAT-Gateway-RT.id
}

# Associate Private Subnet 2 with NAT Gateway Route Table
resource "aws_route_table_association" "nat_gateway_route_table_association_2" {
  subnet_id      = var.private_subnet_id["private_subnet_2"]
  route_table_id = aws_route_table.NAT-Gateway-RT.id
}

# Associate Private Subnet 3 with NAT Gateway Route Table
resource "aws_route_table_association" "nat_gateway_route_table_association_3" {
  subnet_id      = var.private_subnet_id["private_subnet_3"]
  route_table_id = aws_route_table.NAT-Gateway-RT.id
}