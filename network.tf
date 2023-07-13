# network.tf

# Create the network VNET
resource "azurerm_virtual_network" "network-vnet" {
  name = "Project09-vnet-DEV"
  address_space = ["10.128.0.0/16"]
  resource_group_name = "S2-RG-Project09-DEV"
  location = "westeurope"

}
