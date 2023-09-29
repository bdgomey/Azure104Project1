resource "azurerm_private_dns_zone" "main" {
  name                = "bjgomes.mysql.database.azure.com"
  resource_group_name = var.resourceGroupName
}

resource "azurerm_private_dns_zone_virtual_network_link" "example" {
  name                  = "exampleVnetZone.com"
  private_dns_zone_name = azurerm_private_dns_zone.main.name
  virtual_network_id    = var.VnetId
  resource_group_name   = var.resourceGroupName
}

resource "azurerm_mysql_flexible_server" "main" {
  name                   = "bjgomes-fs"
  resource_group_name    = var.resourceGroupName
  location               = var.resourceGroupLocation
  administrator_login    = "psqladmin"
  administrator_password = "H@Sh1CoR3!"
  backup_retention_days  = 7
  delegated_subnet_id    = var.databaseSubnetId
  private_dns_zone_id    = azurerm_private_dns_zone.main.id
  sku_name               = "GP_Standard_B1ms"

  depends_on = [azurerm_private_dns_zone_virtual_network_link.example]
}

resource "azurerm_mysql_flexible_database" "main" {
  name                = "bjgomes-mysql-flexible-database"
  resource_group_name = var.resourceGroupName
  server_name         = azurerm_mysql_flexible_server.main.name
  charset             = "utf8"
  collation           = "utf8_unicode_ci"
}