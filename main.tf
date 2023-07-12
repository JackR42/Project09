### BEGIN INIT
provider "azurerm" {
  features {}
}

terraform {
  backend "azurerm" {}
}

### BEGIN MAIN
resource "azurerm_resource_group" "project" {
  name = var.rg_name
  location = var.loc_name
}
