### BEGIN KeyVault
data "azurerm_key_vault" "project" {
  name                = "keyvaultProject09564209"
  resource_group_name = "S1-RG-CORE"
}
data "azurerm_key_vault_secret" "secret0" {
  name         = "ARM-RG-Project"
  key_vault_id = data.azurerm_key_vault.project.id
}
data "azurerm_key_vault_secret" "secret1" {
  name         = "SQLServer-InstanceName"
  key_vault_id = data.azurerm_key_vault.project.id
}
data "azurerm_key_vault_secret" "secret2" {
  name         = "SQLServer-InstanceAdminUserName"
  key_vault_id = data.azurerm_key_vault.project.id
}
data "azurerm_key_vault_secret" "secret3" {
  name         = "SQLServer-InstanceAdminPassword"
  key_vault_id = data.azurerm_key_vault.project.id
}
data "azurerm_key_vault_secret" "secret4" {
  name         = "SQLServer-Database1Name"
  key_vault_id = data.azurerm_key_vault.project.id
}
data "azurerm_key_vault_secret" "secret5" {
  name         = "WebSite-StorageName"
  key_vault_id = data.azurerm_key_vault.project.id
}

### END KeyVault

### BEGIN INIT
provider "azurerm" {
  features {}
}

terraform {
  backend "azurerm" {}
}

### BEGIN MAIN
resource "azurerm_resource_group" "project" {
  name = "${var.sub-name}-RG-${var.app-name}-${var.env-name}"
  location = "${var.loc-name}"

  tags = {
    Subscription = var.sub-name
    Application = var.app-name
    Environment = var.env-name
  }
}
