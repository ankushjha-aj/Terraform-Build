# Provider Configuration
provider "aws" {
  region = var.region
}

# VPC Module
module "vpc" {
  source              = "./modules/aws_vpc"
  vpc_cidr_block      = var.vpc_cidr_block
  domain_name         = var.domain_name
  domain_name_servers = var.domain_name_servers
}

# Internet Gateway Module
module "igw" {
  source = "./modules/aws_internet_gateway"
  vpc_id = module.vpc.vpc_id
}

# NAT Gateway Module
module "nat_gateway" {
  source           = "./modules/aws_nat_gateway"
  public_subnet_id = module.subnet.public_subnet_ids
  vpc_id           = module.vpc.vpc_id
  depends_on       = [module.igw] # Add dependency on igw module 
}

# Route Table Module
module "route_table" {
  source            = "./modules/aws_route_table"
  vpc_id            = module.vpc.vpc_id
  igw_id            = module.igw.igw_id
  public_subnet_id  = module.subnet.public_subnet_ids
  private_subnet_id = module.subnet.private_subnet_ids
  nat_gateway_id    = module.nat_gateway.nat_gateway_id
}

# Subnet Module
module "subnet" {
  source              = "./modules/aws_subnet"
  vpc_id              = module.vpc.vpc_id
  public_subnet_conf  = var.public_subnet_conf
  private_subnet_conf = var.private_subnet_conf
}
module "target_group" {
  source              = "./modules/aws_target_group"
  name                = var.target_group_name
  port                = var.target_group_port
  protocol            = var.target_group_protocol
  vpc_id              = module.vpc.vpc_id
  healthy_threshold   = var.healthy_threshold
  unhealthy_threshold = var.unhealthy_threshold
  timeout             = var.timeout
  interval            = var.interval
  path                = var.path
}

module "lb_security_group" {
  source         = "./modules/aws_lb_security_group"
  vpc_id         = module.vpc.vpc_id
  lb_name        = var.lb_name
  lb_description = var.lb_security_group_description
  lb_tags        = var.lb_tags
}

module "ec2_security_group" {
  source          = "./modules/aws_ec2_security_group"
  vpc_id          = module.vpc.vpc_id
  ec2_name        = var.ec2_name
  ec2_description = var.ec2_security_group_description
  ec2_tags        = var.ec2_tags
}

# EC2 Instance Module (Optional, if you want to create an EC2 instance in this root configuration)
module "ec2_instance" {
  source            = "./modules/aws_ec2"
  aws_ami           = var.aws_ami
  aws_instance_type = var.aws_instance_type
  public_subnet_id  = module.subnet.public_subnet_ids
  target_group_arn  = module.target_group.target_group_arn
  vpc_id            = module.vpc.vpc_id
  security_group_id = module.ec2_security_group.security_group_id
  depends_on        = [module.ec2_security_group]


}

module "aws_s3" {
  source      = "./modules/aws_s3"
  bucket_name = var.bucket_name
  # acl = "private"
  # versioning = true
  # tags = {
  #     Name = "My bucket"
  #     }      
}
