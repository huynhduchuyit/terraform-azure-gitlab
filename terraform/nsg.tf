resource "azurerm_network_security_group" "gl_nsg" {
  name                = "nsg-${var.project}"
  location            = data.azurerm_resource_group.gl_rg.location
  resource_group_name = data.azurerm_resource_group.gl_rg.name

  security_rule {
    name                       = "SSH"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "HTTP"
    priority                   = 200
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

resource "azurerm_network_interface_security_group_association" "gl_nic_nsg" {
  network_interface_id      = azurerm_network_interface.gl_nic.id
  network_security_group_id = azurerm_network_security_group.gl_nsg.id

  depends_on = [
    azurerm_network_interface.gl_nic,
    azurerm_network_security_group.gl_nsg
  ]
}
