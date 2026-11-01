terraform {
  required_providers {
    azurerm ={
        source = "hashicorp/azurerm"
        version = "5.3.0"
    }
  }
}
provider "azurerm" {
    features {}
}
resource "azurerm_resource_group" "rgs" {
    name     = "rg-terraform"
    location = "East US"
     lifecycle {
        prevent_destroy = true
    }
    }

    output "resource_group_name" {
        value = {name = azurerm_resource_group.rgs.name
        location = azurerm_resource_group.rgs.location}
    }
  