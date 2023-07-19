resource "azurerm_mssql_server" "project-sqldb1" {
  name  = data.azurerm_key_vault_secret.secret1.value
  resource_group_name = azurerm_resource_group.project.name
#  location            = azurerm_resource_group.project.location
  location            = "East US"
  version = "12.0"
  administrator_login          = data.azurerm_key_vault_secret.secret2.value
  administrator_login_password = data.azurerm_key_vault_secret.secret3.value

  identity {
    type = "SystemAssigned"
  }

  tags = {
    Subscription = var.sub-name
    Application = var.app-name
    Environment = var.env-name
  }
}