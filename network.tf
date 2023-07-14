# Create the VNET
resource "azurerm_virtual_network" "project-vnet" {
  name                = "${var.app-name}-vnet-${var.env-name}"
  address_space       = [var.vnet-cidr]
  resource_group_name = azurerm_resource_group.project.name
  location            = azurerm_resource_group.project.location
  tags = {
    environment = var.env-name
  }
}
