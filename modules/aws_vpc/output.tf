# The Id of the vpc
output "vpc_id" {
  value = aws_vpc.aws_test_vpc.id
}

output "dhcp_options_id" {
  value = aws_vpc_dhcp_options.domain.id
}