locals {
  address_space = join("/", [var.networkAddress, tostring(var.networkAddressMask)])
}

resource "azurerm_resource_group" "main" {
    name     = "bjgomes-terraform-rg"
    location = "eastus"
}

resource "azurerm_virtual_network" "main" {
  name                = "bjgomes-network"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  address_space       = [local.address_space]
}

resource "azurerm_subnet" "dataBaseSubnet" {
  name                 = "DataBaseSubnet"
  resource_group_name  = azurerm_resource_group.main.name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes     = [cidrsubnet(local.address_space
  , 8, 0)]

  delegation {
    name = "delegation"

    service_delegation {
      name    = "Microsoft.DBforMySQL/flexibleServers"
        actions = ["Microsoft.Network/virtualNetworks/subnets/action"]
    }
  }
}

resource "azurerm_subnet" "gatewaySubnet" {
  name                 = "GatewaySubnet"
  resource_group_name  = azurerm_resource_group.main.name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes     = [cidrsubnet(local.address_space
  , 8, 1)]

}

resource "azurerm_subnet" "Subnets" {
  count = 5
  name                 = "Subnet-${count.index}"
  resource_group_name  = azurerm_resource_group.main.name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes     = [cidrsubnet(local.address_space
  , 8, count.index + 2)]

}