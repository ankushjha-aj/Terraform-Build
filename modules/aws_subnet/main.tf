# Resource for creating Public subnet!
resource "aws_subnet" "aws_public_subnet" {
  for_each                = var.public_subnet_conf
  vpc_id                  = var.vpc_id
  cidr_block              = each.value.cidr_block
  availability_zone       = each.value.availability_zone
  map_public_ip_on_launch = true
  tags = {
    Name = "Ankush-${each.key}"
  }
}

# Resouce for creating Private subnet!
resource "aws_subnet" "aws_private_subnet" {
  for_each          = var.private_subnet_conf 
  vpc_id            = var.vpc_id
  cidr_block        = each.value.cidr_block
  availability_zone = each.value.availability_zone
  tags = {
    Name = "Ankush-${each.key}"
  }
}
