## SUBNET - assigned to VNET
resource "azurerm_subnet" "project-subnet" {
  name                = "AzureBastionSubnet"
  resource_group_name = azurerm_resource_group.project.name

  virtual_network_name = azurerm_virtual_network.project-vnet.name
  address_prefixes     = [var.bastion-subnet-cidr] 
}

## PIP - PUBLIC IP
resource "azurerm_public_ip" "project-pip" {
  name                = "${var.app-name}-pip-${var.env-name}"
  resource_group_name = azurerm_resource_group.project.name
  location            = azurerm_resource_group.project.location
  allocation_method   = "Static"
  sku                 = "Standard"
}

##BASTION HOST
resource "azurerm_bastion_host" "project-bastion" {
  name                = "${var.app-name}-bastion-${var.env-name}"
  resource_group_name = azurerm_resource_group.project.name
  location            = azurerm_resource_group.project.location

  ip_configuration {
    name                 = "configuration"
    subnet_id            = azurerm_subnet.project-subnet.id
    public_ip_address_id = azurerm_public_ip.project-pip.id
  }
}

## NSG - NETWORK SECURITY GROUP 
# Create Network Security Group to Access Bastion VM from Internet
resource "azurerm_network_security_group" "project-nsg" {
  name                = "${var.app-name}-nsg-${var.env-name}"
  resource_group_name = azurerm_resource_group.project.name
  location            = azurerm_resource_group.project.location

  security_rule {
    name                       = "RuleAllowRDP"
    description                = "Allow RDP"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "3389"
    source_address_prefix      = "Internet"
    destination_address_prefix = "*" 
  }

  tags = {
    subscription = var.sub-name
    application = var.app-name
    environment = var.env-name
  }
}

# Associate the Bastion NSG with the Subnet
resource "azurerm_subnet_network_security_group_association" "project-subnet-nsg-association" {
  subnet_id                 = azurerm_subnet.project-subnet.id
  network_security_group_id = azurerm_network_security_group.project-nsg.id
}

# Get a Static Public IP
resource "azurerm_public_ip" "project-vm-windows-pip" {
  name                = "${var.prefix}-${var.environment}-bastion-windows-ip"
  name                = "${var.app-name}-project-vm-windows-pip-${var.env-name}"
  resource_group_name = azurerm_resource_group.project.name
  location            = azurerm_resource_group.project.location
  allocation_method   = "Static"
  
  tags = {
    subscription = var.sub-name
    application = var.app-name
    environment = var.env-name
  }
}

# NIC - Create Network Card for VM
resource "azurerm_network_interface" "project-windows-vm-nic" {
  depends_on=[azurerm_public_ip.project-windows-vm-pip]

  name                = "${var.prefix}-${var.environment}-bastion-windows-nic"
  resource_group_name = azurerm_resource_group.project.name
  location            = azurerm_resource_group.project.location

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.project-subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.project-windows-vm-pip.id
  }

  tags = {
    subscription = var.sub-name
    application = var.app-name
    environment = var.env-name
  }
}
