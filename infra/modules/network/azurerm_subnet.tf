# サブネット作成
resource "azurerm_subnet" "web_subnet" {
  name                 = "web-subnet"
  resource_group_name  = var.resource_group.name
  virtual_network_name = azurerm_virtual_network.web_vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}
