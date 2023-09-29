resource "azurerm_resource_group" "main" {
  name     = var.resourceGroupName
  location = var.resourceGroupLocation
}

module "network" {
  source                = "./vnet"
  resourceGroupName     = azurerm_resource_group.main.name
  resourceGroupLocation = azurerm_resource_group.main.location
  subnetCount           = var.subnetCount
  networkName           = var.networkName
  networkAddress        = var.networkAddress
  networkAddressMask    = var.networkAddressMask
}

module "database" {
  source                = "./database"
  resourceGroupName     = azurerm_resource_group.main.name
  resourceGroupLocation = azurerm_resource_group.main.location
  databaseSubnetId      = module.network.databaseSubnetId
  VnetId                = module.network.VnetId

}