terraform {
  required_version = "=1.10.5"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">=4.20"
    }
  }
}

provider "azurerm" {
  resource_provider_registrations = "none"
  subscription_id                 = var.subscription_id
  features {}
}

resource "azurerm_resource_group" "resource_group" {
  name     = "${var.app_name}-resource-group"
  location = var.location
}

# Resource Providers
module "resource_providers" {
  source = "./modules/resource_providers"

  providers_to_register = [
    "Microsoft.Compute",
    "Microsoft.Network"
  ]
}

# Create a virtual network
module "namework" {
  source         = "./modules/network"
  resource_group = azurerm_resource_group.resource_group
}

# Virtual Machine
module "vm" {
  source                       = "./modules/vm"
  resource_group               = azurerm_resource_group.resource_group
  network_interface_web_nic_id = module.namework.network_interface_web_nic_id
  vm_size                      = var.vm_size
  admin_username               = var.admin_username
  vm_name                      = var.vm_name
}
