locals {
  address_space = join("/", [var.networkAddress, tostring(var.networkAddressMask)])
}


resource "azurerm_virtual_network" "main" {
  name                = var.networkName
  location            = var.resourceGroupLocation
  resource_group_name = var.resourceGroupName
  address_space       = [local.address_space]
}

resource "azurerm_subnet" "dataBaseSubnet" {
  name                 = "DataBaseSubnet"
  resource_group_name  = var.resourceGroupName
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes = [cidrsubnet(local.address_space
  , 8, 0)]
  private_endpoint_network_policies_enabled = false

  delegation {
    name = "delegation"

    service_delegation {
      name    = "Microsoft.DBforMySQL/flexibleServers"
      actions = ["Microsoft.Network/virtualNetworks/subnets/join/action"]
    }
  }
}

resource "azurerm_subnet" "gatewaySubnet" {
  name                 = "GatewaySubnet"
  resource_group_name  = var.resourceGroupName
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes = [cidrsubnet(local.address_space
  , 8, 1)]

}

resource "azurerm_subnet" "Subnets" {
  count                = var.subnetCount
  name                 = "Subnet-${count.index}"
  resource_group_name  = var.resourceGroupName
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes = [cidrsubnet(local.address_space
  , 8, count.index + 2)]

}