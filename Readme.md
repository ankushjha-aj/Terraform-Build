# Project Title: Clearly states the project's focus: Terraform AWS Infrastructure.
Description: Provides a concise overview of the modular structure and its benefits.

# Project Structure:
1. Uses a code snippet to illustrate the directory layout, making it easy to visualize.
2. Explains the purpose of each file and directory:
3. modules/: Houses individual Terraform modules.
4. main.tf: The central configuration file that ties everything together.
5. my-key-pair.pub: Your public SSH key for secure access to EC2 instances (a crucial security detail).
6. outputs.tf: Defines values (like instance IPs) that are made available after Terraform runs.
7. variables.tf: Declares variables that can be used throughout the configuration.

# Usage Instructions:
1. Lists prerequisites (Terraform installation, AWS credentials).
2. Outlines the step-by-step commands to initialize, plan, and apply the Terraform configuration. This is essential for anyone new to the project.
3. Modules: Provides a list of all the modules, each serving a specific AWS resource type. This serves as a quick reference guide.
4. Contributing: Encourages contributions and provides a way to report issues. This fosters a collaborative environment.
5. Terraform Project Structure
6. The heart of this project lies in its modularity. Each resource type (EC2 instance, security group, VPC, etc.) gets its own module:

# Benefits of Modules:
1. Reusability: You can easily use the same module across different projects or environments.
2. Maintainability: Changes are isolated to specific modules, simplifying updates.
3. Readability: The project structure is cleaner and easier to understand.

# Inside a Module:
1. main.tf: Defines the resources (e.g., an EC2 instance) and their configurations.
2. variables.tf: Declares variables that allow you to customize the module's behavior.
3. outputs.tf: Specifies values from the module that you might want to use elsewhere (like the instance's public IP).

# How to run this project 

# Prerequisites
1. Terraform: Install Terraform (https://www.terraform.io/downloads.html) and ensure it's accessible from your command line.
2. AWS CLI: Install the AWS Command Line Interface (https://docs.aws.amazon.com/cli/latest/userguide/gettingstarted_install.html) and configure it with your AWS access key and secret key.
3. AWS Account: You'll need an AWS account to create resources.

# Requirements
Terraform version >= 0.12
AWS account with sufficient privileges to create resources (e.g., EC2 instances, security groups, etc) (https://aws.amazon.com/free/)

# Clone Repository via gitbash terminal or any terminal: 
1. git clone https://github.com/ankushjha-aj/Terraform-CLOUD.git  
2. cd Terraform-CLOUD/
3. git checkout AWS (the code is in AWS Branch)
4. code . (This will open folder in your VS-Code) 

# After Cloning run foloowing commands in the terminal to run the project :
1. terraform init
2. terraform plan
3. terraform apply
4. terraform destroy --> run this only if you want to delete all resources you created via teraform Scripts.