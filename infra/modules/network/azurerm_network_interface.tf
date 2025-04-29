# ネットワークインターフェース作成
resource "azurerm_network_interface" "web_nic" {
  name                = "web-nic"
  location            = var.resource_group.location
  resource_group_name = var.resource_group.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.web_subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.web_pip.id
  }
}
