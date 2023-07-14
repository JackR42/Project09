resource "azurerm_subnet" "project-subnet" {
  name                = "AzureBastionSubnet"
  resource_group_name = azurerm_resource_group.project.name

  virtual_network_name = azurerm_virtual_network.project-vnet.name
  address_prefixes     = [var.bastion-subnet-cidr] 
}

resource "azurerm_public_ip" "project-pip" {
  name                = "examplepip"
  resource_group_name = azurerm_resource_group.project.name
  location            = azurerm_resource_group.project.location
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_bastion_host" "project-bastion" {
  name                = "${var.app-name}-bastion-${var.env-name}"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name

  ip_configuration {
    name                 = "configuration"
    subnet_id            = azurerm_subnet.project-subnet.id
    public_ip_address_id = azurerm_public_ip.project-pip.id
  }
}
