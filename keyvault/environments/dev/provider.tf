terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "5.9.0"
    }
  }
  backend "azurerm" {

    resource_group_name  = "ado-rg"
    storage_account_name = "iftiado1"
    container_name       = "tfstate"
    key                  = "terraform.tfstate"

  }
}
provider "azurerm" {
  features {}

}