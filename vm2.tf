# Create network interface
resource "azurerm_network_interface" "project-nic-vm2" {
  name                = "${var.app-name}-nic-vm2-${var.env-name}"
  resource_group_name = azurerm_resource_group.project.name
  location            = azurerm_resource_group.project.location

  ip_configuration {
    name                          = "ipconfig"
    subnet_id                     = azurerm_subnet.project-subnet.id
    private_ip_address_allocation = "Dynamic"
  }

  tags = {
    Subscription = var.sub-name
    Application = var.app-name
    Environment = var.env-name
  }
}

resource "azurerm_windows_virtual_machine" "project-vm2" {
  name                = "${var.vm2-name}"
  resource_group_name = azurerm_resource_group.project.name
  location            = azurerm_resource_group.project.location
  size                = "Standard_DS2_v2"
  admin_username       = data.azurerm_key_vault_secret.secret2.value
  admin_password       = data.azurerm_key_vault_secret.secret3.value  

  network_interface_ids = [
    azurerm_network_interface.project-nic-vm2.id
  ]

  os_disk {
    name                 = "${var.app-name}-disk-os-vm2-${var.env-name}"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftSQLServer"
    offer     = "sql2022-ws2022"
    sku       = "SQLDEV"
    version   = "latest"
  }

  tags = {
    Subscription = var.sub-name
    Application = var.app-name
    Environment = var.env-name
  }
}

# Auto shutdown VM2

resource "azurerm_dev_test_global_vm_shutdown_schedule" "project-shutdown-vm2" {
  virtual_machine_id = azurerm_windows_virtual_machine.project-vm2.id
  location            = azurerm_resource_group.project.location
  enabled            = true

  daily_recurrence_time = "2000"
  timezone              = "W. Europe Standard Time"

  notification_settings {
    enabled         = false   
  }

  tags = {
    Subscription = var.sub-name
    Application = var.app-name
    Environment = var.env-name
  }
 }
