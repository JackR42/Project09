# Create the VNET - main network
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

# Create subnet Bastion
resource "azurerm_subnet" "project-subnet-bastion" {
  name                 = "AzureBastionSubnet"
  resource_group_name  = azurerm_resource_group.project.name
  virtual_network_name = azurerm_virtual_network.project-vnet.name
  address_prefixes     = [var.subnet-cidr-bastion]
}

resource "azurerm_subnet" "project_subnet-vm1" {
  name                = "${var.app-name}-subnet-vm1-${var.env-name}"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = [var.subnet-cidr-vm1]
}
