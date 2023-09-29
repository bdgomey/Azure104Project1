locals {
  address_space = join("/", [var.networkAddress, tostring(var.network_address_mask)])
  
  dynamicSubnets = [
    for item in var.subnetConfig : {
      subnet_name = item.name
      cidr_block = join("/", [item.cidr_base, tostring(item.mask)])
    }
  ]
}

resource "azurerm_resource_group" "main" {
    name = var.resourceGroupName
    location = var.location
}

#Vnet
resource "azurerm_virtual_network" "main" {
  name = var.vnetName
  location = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name #####
  address_space = [local.address_space]
  
}
#Public Subnet
resource "azurerm_subnet" "public" {
  for_each = {
    for subnet in local.dynamicSubnets : "${subnet.subnet_name}.${subnet.cidr_block}" => subnet
  }  
  name = each.value.subnet_name
  resource_group_name = azurerm_resource_group.main.name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes = [each.value.cidr_block]
}