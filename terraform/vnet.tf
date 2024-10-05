resource "azurerm_virtual_network" "gl_vnet" {
  name                = "vnet-${var.project}"
  location            = data.azurerm_resource_group.gl_rg.location
  resource_group_name = data.azurerm_resource_group.gl_rg.name
  address_space       = [var.vnet_cidr]
}

resource "azurerm_subnet" "gl_subnet" {
  name                 = "subnet-${var.project}"
  resource_group_name  = data.azurerm_resource_group.gl_rg.name
  virtual_network_name = azurerm_virtual_network.gl_vnet.name
  address_prefixes     = [var.subnet_cidr]

  depends_on = [
    azurerm_virtual_network.gl_vnet
  ]
}
