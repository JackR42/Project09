resource "azurerm_mssql_failover_group" "project-failovergroup" {
  name      = "project09-failovergroup1"
  server_id = azurerm_mssql_server.project-db1.id
  databases = [
    azurerm_mssql_database.project-db1.id,
  ]
  partner_server {
    id = azurerm_mssql_server.project-db2.id
  }
  read_write_endpoint_failover_policy {
    mode          = "Automatic"
    grace_minutes = 60
  }
}