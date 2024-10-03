resource "azurerm_virtual_network" "gl_vnet" {
  name                = "vnet-${var.project}"
  location            = azurerm_resource_group.gl_rg.location
  resource_group_name = azurerm_resource_group.gl_rg.name
  address_space       = [var.vnet_cidr]

  depends_on = [azurerm_resource_group.gl_rg]
}

resource "azurerm_subnet" "gl_subnet" {
  name                 = "subnet-${var.project}"
  resource_group_name  = azurerm_resource_group.gl_rg.name
  virtual_network_name = azurerm_virtual_network.gl_vnet.name
  address_prefixes     = [var.subnet_cidr]

  depends_on = [
    azurerm_resource_group.gl_rg,
    azurerm_virtual_network.gl_vnet
  ]
}
