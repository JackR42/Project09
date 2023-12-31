# Create network interface
resource "azurerm_network_interface" "project-nic-vm0" {
  name                = "${var.app-name}-nic-vm0-${var.env-name}"
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

resource "azurerm_windows_virtual_machine" "project-vm0" {
  name                = "${var.vm0-name}"
  resource_group_name = azurerm_resource_group.project.name
  location            = azurerm_resource_group.project.location
  size                = "Standard_DS2_v2"
  admin_username       = data.azurerm_key_vault_secret.secret2.value
  admin_password       = data.azurerm_key_vault_secret.secret3.value  

  network_interface_ids = [
    azurerm_network_interface.project-nic-vm0.id
  ]

  os_disk {
    name                 = "${var.app-name}-disk-os-vm0-${var.env-name}"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2022-Datacenter"
    version   = "latest"
  }

  tags = {
    Subscription = var.sub-name
    Application = var.app-name
    Environment = var.env-name
  }
}

#Install VM Features via Powershell script
resource "azurerm_virtual_machine_extension" "project-vm0-install" {
  name                 = "${var.app-name}-vm0-install-${var.env-name}"
  virtual_machine_id   = azurerm_windows_virtual_machine.project-vm0.id
  publisher            = "Microsoft.Compute"
  type                 = "CustomScriptExtension"
  type_handler_version = "1.9"

  protected_settings = <<SETTINGS
  {    
    "commandToExecute": "powershell -command \"[System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String('${base64encode(data.template_file.VM-Install.rendered)}')) | Out-File -filepath VM-Install.ps1\" && powershell -ExecutionPolicy Unrestricted -File VM-Install.ps1 -Project ${data.template_file.VM-Install.vars.project}}"
  }
  SETTINGS
}

# Auto shutdown VM0
resource "azurerm_dev_test_global_vm_shutdown_schedule" "project-shutdown-vm0" {
  virtual_machine_id = azurerm_windows_virtual_machine.project-vm0.id
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
