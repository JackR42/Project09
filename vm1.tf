# Create network interface
resource "azurerm_network_interface" "project-nic-vm1" {
  name                = "${var.app-name}-nic-vm1-${var.env-name}"
  resource_group_name = azurerm_resource_group.project.name
  location            = azurerm_resource_group.project.location

  ip_configuration {
    name                          = "ipconfig"
    subnet_id                     = azurerm_subnet.project-subnet-vm1.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_windows_virtual_machine" "project-vm1" {
  name                = "VM1"
  resource_group_name = azurerm_resource_group.project.name
  location            = azurerm_resource_group.project.location
  size                = "Standard_DS2_v2"
  admin_username       = data.azurerm_key_vault_secret.secret2.value
  admin_password       = data.azurerm_key_vault_secret.secret3.value  

  network_interface_ids = [
    azurerm_network_interface.project-nic-vm1.id
  ]

  os_disk {
    name                 = "${var.app-name}-disk-os-vm1-${var.env-name}"
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

# Auto shutdown VM

resource "azurerm_dev_test_global_vm_shutdown_schedule" "project-shutdown" {
  virtual_machine_id = azurerm_windows_virtual_machine.project-vm1.id
  location            = azurerm_resource_group.project.location
  enabled            = true

  daily_recurrence_time = "2000"
  timezone              = "W. Europe Standard Time"

  notification_settings {
    enabled         = false   
  }
 }
