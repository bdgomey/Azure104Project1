output "VnetId" {
  value = azurerm_virtual_network.main.id
}

output "databaseSubnetId" {
  value = azurerm_subnet.dataBaseSubnet.id
}