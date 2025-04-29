# パブリックIP作成
resource "azurerm_public_ip" "web_pip" {
  name                = "web-pip"
  location            = var.resource_group.location
  resource_group_name = var.resource_group.name
  allocation_method   = "Static"  # DynamicからStaticに変更
  sku                 = "Standard"  # Standard SKUを明示的に指定
  domain_name_label   = "webserver-${random_string.random.result}"
}

resource "random_string" "random" {
  length  = 8
  special = false
  upper   = false
}
