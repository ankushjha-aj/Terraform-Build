# Provider Configuration
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0" 
    }
  }
}

# Resource Group
resource "azurerm_resource_group" "rg" {
  name     = "devops-rg"
  location = "Australia East" 
}

# Virtual Network
resource "azurerm_virtual_network" "vnet" {
  name                = "devops-vnet"
  address_space       = ["10.0.0.0/16"]
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
}

# Subnet
resource "azurerm_subnet" "subnet" {
  name                 = "devops-subnet"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}

# Public IP
resource "azurerm_public_ip" "public_ip" {
  name                = "dev-ops-public-ip"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  allocation_method   = "Dynamic" 
}

# Network Interface
resource "azurerm_network_interface" "nic" {
  name                      = "dev-ops-nic"
  resource_group_name       = azurerm_resource_group.rg.name
  location                  = azurerm_resource_group.rg.location
  ip_configuration {
    name                          = "dev-ops-ip-config"
    subnet_id                     = azurerm_subnet.subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.public_ip.id 
  }
}

# Virtual Machine
resource "azurerm_linux_virtual_machine" "vm" {
  name                  = "Dev-ops-1"
  resource_group_name   = azurerm_resource_group.rg.name
  location              = azurerm_resource_group.rg.location
  size                  = "Standard_B1s" 
  admin_username        = "ankush" 
  admin_ssh_key {
    username   = "ankush"
    public_key = "ssh-rsa AAAAB3NzaC1yc2EAAA..........................."
    # Change Key Acoording to yourself
  }
  network_interface_ids = [azurerm_network_interface.nic.id]
  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS" 
  }
  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts-gen2"
    version   = "latest"
  }
}
