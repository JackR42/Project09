resource "azurerm_public_ip" "project-pip-bastion" {
  name                = "${var.app-name}-pip-bastion-${var.env-name}"
  resource_group_name = azurerm_resource_group.project.name
  location            = azurerm_resource_group.project.location
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_bastion_host" "project-bastion-host" {
  name                = "${var.app-name}-bastion-host-${var.env-name}"
  resource_group_name = azurerm_resource_group.project.name
  location            = azurerm_resource_group.project.location
  sku                 = "Standard"
  scale_units         = 2

  copy_paste_enabled     = true
  file_copy_enabled      = true
  shareable_link_enabled = true
  tunneling_enabled      = true

  ip_configuration {
    name                 = "config-01"
    subnet_id            = azurerm_subnet.project-subnet-bastion.id
    public_ip_address_id = azurerm_public_ip.project-pip-bastion.id
  }
}
