# The ID of the created NAT gateway.
output "nat_gateway_id" {
  value = aws_nat_gateway.aws_nat_gateway.id
}

#  The ID of the allocated Elastic IP address.
output "eip_allocation_id" {
  value = aws_eip.eip_nat_gateway.allocation_id
}