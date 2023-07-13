# network.tf

# Create the network VNET
resource "azurerm_virtual_network" "network-vnet" {
#  name                = "${lower(replace(var.app_name," ","-"))}-${var.environment}-vnet"
  name                = "Project09-vnet-DEV"
  address_space       = [var.network-vnet-cidr]
#  resource_group_name = azurerm_resource_group.network-rg.name
   resource_group_name = azurerm_resource_group.project.name
#  location            = azurerm_resource_group.network-rg.location
  location             = azurerm_resource_group.project.location

tags = {
    application = var.app-name
    environment = var.env-name
  }
}
