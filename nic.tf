resource "azurerm_network_interface" "gl_nic" {
  name                = "nic-${var.project}"
  location            = azurerm_resource_group.gl_rg.location
  resource_group_name = azurerm_resource_group.gl_rg.name

  ip_configuration {
    name                          = "nic-ipconfig-${var.project}"
    subnet_id                     = azurerm_subnet.gl_subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.gl_pip.id
  }

  depends_on = [
    azurerm_resource_group.gl_rg,
    azurerm_subnet.gl_subnet,
    azurerm_public_ip.gl_pip
  ]
}
