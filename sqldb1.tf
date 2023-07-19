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

# Create FW rule to allow access from AZURE SERVICES, e.g. PowerApp
resource "azurerm_mssql_firewall_rule" "project-sqldb1fw0" {
  name = "FirewallRulesqldb1fw0"
  server_id = azurerm_mssql_server.project-sqldb1.id
  start_ip_address = "0.0.0.0"
  end_ip_address = "0.0.0.0"
}
# Create FW rule to allow access from OFFICE
resource "azurerm_mssql_firewall_rule" "project-sqldb1fw1" {
  name = "FirewallRuledsqlb1fw1"
  server_id = azurerm_mssql_server.project-sqldb1.id
  start_ip_address = "91.205.194.1"
  end_ip_address = "91.205.194.1"
}
# Create FW rule to allow access from HOME
resource "azurerm_mssql_firewall_rule" "project-sqldb1fw2" {
  name = "FirewallRulesqldb1fw2"
  server_id = azurerm_mssql_server.project-sqldb1.id
  start_ip_address = "94.209.108.55"
  end_ip_address = "94.209.108.55"
}
