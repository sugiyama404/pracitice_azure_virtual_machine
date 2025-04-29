# ネットワークセキュリティグループ作成
resource "azurerm_network_security_group" "web_nsg" {
  name                = "web-nsg"
  location            = var.resource_group.location
  resource_group_name = var.resource_group.name
}
