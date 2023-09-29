#resourceGroup
resourceGroupName = "rg-az-vm-01"
location = "eastus"
vnetName = "vnet-az-vm-01"
networkAddress = "10.0.0.0"
network_address_mask = 16
subnetConfig = {
    subnet1 = {
    name      = "public1"
    mask      = 24
    cidr_base = "10.30.1.0"
  }
}
