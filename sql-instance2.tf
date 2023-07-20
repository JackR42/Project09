resource "azurerm_mssql_server" "project-sql-instance2" {
  name  = data.azurerm_key_vault_secret.secret7.value
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

# Create FW rule to allow access from AZURE SERVICES, e.g. PowerApp
resource "azurerm_mssql_firewall_rule" "project-sql-instance2fw0" {
  name = "FirewallRule-sql-instance2-fw0"
  server_id = azurerm_mssql_server.project-sql-instance2.id
  start_ip_address = "0.0.0.0"
  end_ip_address = "0.0.0.0"
}
# Create FW rule to allow access from OFFICE
resource "azurerm_mssql_firewall_rule" "project-sql-instance2-fw1" {
  name = "FirewallRule-sql-instance2-fw1"
  server_id = azurerm_mssql_server.project-sql-instance2.id
  start_ip_address = "91.205.194.1"
  end_ip_address = "91.205.194.1"
}
# Create FW rule to allow access from HOME
resource "azurerm_mssql_firewall_rule" "project-sql-instance2-fw2" {
  name = "FirewallRule-sql-instance2-fw2"
  server_id = azurerm_mssql_server.project-sql-instance2.id
  start_ip_address = "94.209.108.55"
  end_ip_address = "94.209.108.55"
}
