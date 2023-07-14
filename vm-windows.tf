# Create network interface
resource "azurerm_network_interface" "project-nic-vm-win01" {
  name                = "${var.app-name}-nic-vm-win01-${var.env-name}"
  resource_group_name = azurerm_resource_group.project.name
  location            = azurerm_resource_group.project.location

  ip_configuration {
    name                          = "ipconfig-project-nic-vm-win01"
    subnet_id                     = azurerm_subnet.project-subnet-vm1.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_windows_virtual_machine" "project-vm-win01" {
  name                = "${var.app-name}-vm-win01-${var.env-name}"
  resource_group_name = azurerm_resource_group.project.name
  location            = azurerm_resource_group.project.location
  size                = "Standard_DS2_v2"
  admin_username      = "Admin42"
  admin_password      = "ABCabc123."
  network_interface_ids = [
    azurerm_network_interface.project-nic-vm-win01.id
  ]

  os_disk {
    name                 = "disk-os-vm-win01"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2022-Datacenter"
    version   = "latest"
  }
}
