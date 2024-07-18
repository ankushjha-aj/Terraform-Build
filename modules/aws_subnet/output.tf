
output "public_subnet_ids" {
  value = {
    for key, subnet in aws_subnet.aws_public_subnet : key => subnet.id
  }
}

output "private_subnet_ids" {
  value = {
    for key, subnet in aws_subnet.aws_private_subnet : key => subnet.id
  }
}


