### BEGIN INIT
provider "azurerm" {
  features {}
}

terraform {
  backend "azurerm" {}
}

### BEGIN MAIN
resource "azurerm_resource_group" "project" {
  name = "${var.sub-name}-RG-${var.app-name}-${var.env-name}"
  location = "${var.loc-name}"
  tags = {
    subscription = var.sub-name
    application = var.app-name
    environment = var.env-name
  }
}
