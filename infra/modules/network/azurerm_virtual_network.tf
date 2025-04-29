# 仮想ネットワーク作成
resource "azurerm_virtual_network" "web_vnet" {
  name                = "web-network"
  address_space       = ["10.0.0.0/16"]
  location            = var.resource_group.location
  resource_group_name = var.resource_group.name
}
