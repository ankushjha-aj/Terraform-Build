# Terraform Configuration for Azure Linux Virtual Machine
This Terraform project automates the creation of a Linux virtual machine (VM) within a resource group in your Azure environment. It configures networking components, security settings, and VM specifications to quickly deploy a functional VM.

# Features
Resource Group: Creates a resource group to logically group Azure resources.
Virtual Network: Sets up a virtual network with a defined address space.
Subnet: Defines a subnet within the virtual network.
Public IP: Associates a dynamic public IP address with the VM for external access.
Network Interface: Creates a network interface to connect the VM to the network.
Linux Virtual Machine: Provisions the Linux VM with specified configurations.

# Security
Optional Network Security Group: Allows for optional network traffic control.
Azure Key Vault Integration: Securely retrieves the SSH public key from Azure Key Vault.
Managed Disks: Uses Managed Disks for the OS disk for enhanced performance and reliability.

# Prerequisites
Terraform: Install Terraform (https://www.terraform.io/downloads.html)
Azure Account: An active Azure subscription.
Azure CLI: Install and configure the Azure CLI (https://docs.microsoft.com/en-us/cli/azure/install-azure-cli).
Azure Service Principal: Create a service principal with appropriate permissions to manage resources in your subscription.

# Configuration
Azure Provider: Configure the Azure provider with your subscription details.
Variables:
rg_location: (Required) The Azure region where resources will be created.
vm_size: (Required) The size of the virtual machine.
Other Variables: If you're using Key Vault, you'll need to define variables for Key Vault access as well.

# Clone Repository via gitbash terminal or any terminal:
1. git clone https://github.com/ankushjha-aj/Terraform-Build.git
2. cd Terraform-Build/
3. git checkout AZURE
4. code .

# After Cloning run foloowing commands in the terminal to run the project :
1. terraform init
2. terraform plan
3. terraform apply
4. terraform destroy --> run this only if you want to delete all resources you created via teraform Scripts.

# NOTE :: --> Before Running your Command please change your Provider details in "provifder.tf" and also change main.tf acoording to your needs.