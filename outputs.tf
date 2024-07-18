output "vpc_id" {
  value = module.vpc.vpc_id
}

# output "public_subnet_ids" {
#   value = module.subnet.public_subnet_ids
# }
# output "private_subnet_ids" {
#   value = module.subnet.private_subnet_ids
# }

# output "igw_id" {
#   value = module.igw.igw_id
# }
# output "nat_gateway_id" {
#   value = module.nat_gateway.nat_gateway_id
# }

output "s3_bucket_arn" {
  value = module.aws_s3.bucket_arn
}

