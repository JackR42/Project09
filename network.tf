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

# Create subnet for backend VMs
resource "azurerm_subnet" "project-subnet" {
  name                = "${var.app-name}-subnet-${var.env-name}"
  resource_group_name  = azurerm_resource_group.project.name
  virtual_network_name = azurerm_virtual_network.project-vnet.name
  address_prefixes     = [var.subnet-cidr]

# Create Network Security Group for VM Subnet and the corresponding rule for RDP from Azure Bastion
resource "azurerm_network_security_group" "project-nsg-subnet" {
  name                = "${var.app-name}-nsg-subnet-${var.env-name}"
  resource_group_name = azurerm_resource_group.project.name
  location            = azurerm_resource_group.project.location

  tags = {
    subscription = var.sub-name
    application = var.app-name
    environment = var.env-name
  }
}

resource "azurerm_network_security_rule" "inbound_allow_rdp" {
  network_security_group_name = azurerm_network_security_group.project-nsg-subnet.name
  name                = "Inbound_Allow_Bastion_RDP"
  resource_group_name = azurerm_resource_group.project.name
  priority                    = 500
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "3389"
  source_address_prefix       = azurerm_subnet.project-subnet-bastion.address_prefixes[0]
  destination_address_prefix  = azurerm_subnet.project-subnet.address_prefixes[0]

  tags = {
    subscription = var.sub-name
    application = var.app-name
    environment = var.env-name
  }
}

resource "azurerm_network_security_rule" "outbound_allow_subnet" {
  network_security_group_name = azurerm_network_security_group.project-nsg-subnet.name
  resource_group_name         = azurerm_resource_group.project.name
  name                        = "Outbound_Allow_Subnet_Any"
  priority                    = 500
  direction                   = "Outbound"
  access                      = "Allow"
  protocol                    = "*"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = azurerm_subnet.project-subnet.address_prefixes[0]
  destination_address_prefix  = azurerm_subnet.project-subnet.address_prefixes[0]

  tags = {
    subscription = var.sub-name
    application = var.app-name
    environment = var.env-name
  }
}

resource "azurerm_subnet_network_security_group_association" "project-nsg-associate_subnet" {
  network_security_group_id = azurerm_network_security_group.project-nsg-subnet.id
  subnet_id                 = azurerm_subnet.project-subnet.id

  tags = {
    subscription = var.sub-name
    application = var.app-name
    environment = var.env-name
  }
}
