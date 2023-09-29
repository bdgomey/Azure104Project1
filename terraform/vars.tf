#resourceGroup
variable "resourceGroupName" {
    type = string
    description = "Resource Group Name"
}
variable "location" {
    type = string
    description = "Location"
}
variable "vnetName" {
    type = string
    description = "VNET name"
}
variable "networkAddress" {
    type = string
    description = "starting cidr block for vnet"
}
variable "network_address_mask" {
    type = number
    description = "(optional) describe your variable"
}
variable "subnetConfig" {
    type = map(any)
    description = "(optional) describe your variable"
}
