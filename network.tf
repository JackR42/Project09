# Create the VNET
resource "azurerm_virtual_network" "project-vnet" {
  name                = "${var.app-name}-vnet-${var.env-name}"
  address_space       = [var.vnet-cidr]
  resource_group_name = azurerm_resource_group.project.name
  location            = azurerm_resource_group.project.location
  tags = {
    subscription = var.sub-name
    application = var.app-name
    environment = var.env-name
  }
}

# Create a subnet for bastion
resource "azurerm_subnet" "bastion-subnet" {
  name                 = "${var.app-name}-bastion-subnet-${var.env-name}"
  address_prefixes     = [var.bastion-subnet-cidr]
  virtual_network_name = azurerm_virtual_network.project-vnet.name
  resource_group_name  = azurerm_resource_group.project.name
}