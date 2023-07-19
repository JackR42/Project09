resource "azurerm_mssql_server" "project-sqldb1" {
  name  = data.azurerm_key_vault_secret.secret6.value
  resource_group_name = azurerm_resource_group.project.name
  location            = azurerm_resource_group.project.location
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

## DB Primary
resource "azurerm_mssql_database" "project-db1" {
  name            = "DBA42"
  server_id       = azurerm_mssql_server.project-sqldb1.id
  license_type    = "LicenseIncluded"
  max_size_gb     = 1
  sku_name        = "GP_S_Gen5_1"
  auto_pause_delay_in_minutes = 60
  min_capacity = 0.5
  storage_account_type = "Local"
  depends_on = [
    azurerm_mssql_server.project-sqldb1
  ]
  tags = {
    Subscription = var.sub-name
    Application = var.app-name
    Environment = var.env-name
  }
}
}