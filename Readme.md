# Terraform-with-AWS

This Terraform project provisions an Ubuntu EC2 instance within your AWS environment, pre-configured to run Docker containers. It includes essential components like a security group, key pair, and default VPC (if needed).

## Key Features

- **Security:** Securely configured security group allowing SSH, MySQL/Aurora, and HTTP access (consider restricting to your IP).
- **Docker Ready:**  Ubuntu AMI specifically chosen for seamless Docker containerization.
- **Customizable:** Easily adapt instance type, security group rules, and tags to your needs.

## Prerequisites

- **AWS Account:** An active AWS account with sufficient permissions to create EC2 instances, security groups, and key pairs.
- **Terraform Installed:** Terraform must be installed on your local machine. Download instructions: [https://www.terraform.io/downloads.html](https://www.terraform.io/downloads.html)
- **AWS Credentials:** Configure your AWS credentials using environment variables or the AWS CLI.

## Getting Started

1. **Clone the Repository:**

   ```bash
   git clone [https://github.com/ankushjha-aj/Terraform-with-aws.git](https://github.com/ankushjha-aj/Terraform-with-aws.git)
   cd Terraform-with-aws

# Modify ec2.tf Configuration:

Update ec2.tf: Adjust instance type, security group rules (restrict IP ranges for production), tags, and any other configuration options to suit your requirements.
Review and Replace: Double-check the public key in the aws_key_pair resource to ensure it's your actual key.

# Initialize, plan and apply Terraform:
terraform init
terraform plan
terraform apply

# Modify provider.tf Configuration:

Create provider.tf: Create a new file named provider.tf and paste the following code, replacing the placeholders with your actual AWS credentials:

provider "aws" {
  region      = "us-east-1"   # Enter your desired region
  access_key  = "YOUR_ACCESS_KEY"
  secret_key  = "YOUR_SECRET_KEY"
}

# Initialize, plan and apply Terraform: 
terraform init
terraform plan
terraform apply

# Connect to Instance:
ssh -i "path_to_your_private_key" ubuntu@public_ip_of_instance 