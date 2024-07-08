# Terraform Configuration for Azure Linux Virtual Machine
This Terraform project automates the creation of a Linux virtual machine (VM) within a resource group in your Azure environment. It configures networking components, security settings, and VM specifications to quickly deploy a functional VM.

# Features
1. Resource Group: Creates a resource group to logically group Azure resources.
2. Virtual Network: Sets up a virtual network with a defined address space.
3. Subnet: Defines a subnet within the virtual network.
4. Public IP: Associates a dynamic public IP address with the VM for external access.
5. Network Interface: Creates a network interface to connect the VM to the network.
6. Linux Virtual Machine: Provisions the Linux VM with specified configurations.

# Security
1. Optional Network Security Group: Allows for optional network traffic control.
2. Azure Key Vault Integration: Securely retrieves the SSH public key from Azure Key Vault.
3. Managed Disks: Uses Managed Disks for the OS disk for enhanced performance and reliability.

# Prerequisites
1. Terraform: Install Terraform (https://www.terraform.io/downloads.html)
2. Azure Account: An active Azure subscription.
3. Azure CLI: Install and configure the Azure CLI (https://docs.microsoft.com/en-us/cli/azure/install-azure-cli).
4. Azure Service Principal: Create a service principal with appropriate permissions to manage resources in your subscription.

# Configuration
1. Azure Provider: Configure the Azure provider with your subscription details.

2. Variables:
    --> rg_location: (Required) The Azure region where resources will be created.
    -->vm_size: (Required) The size of the virtual machine.
3. Other Variables: If you're using Key Vault, you'll need to define variables for Key Vault access as well.

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

# NOTE :: --> Before Running your Command please change your Provider details in "provifder.tf" and also change main.tf SSH KEY with Your Key.