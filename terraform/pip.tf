resource "azurerm_public_ip" "gl_pip" {
  name                = "pip-${var.project}"
  resource_group_name = data.azurerm_resource_group.gl_rg.name
  location            = data.azurerm_resource_group.gl_rg.location
  allocation_method   = "Static"
}
