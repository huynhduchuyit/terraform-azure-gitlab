resource "azurerm_linux_virtual_machine" "gl_vm" {
  name                  = "vm-${var.project}"
  resource_group_name   = data.azurerm_resource_group.gl_rg.name
  location              = data.azurerm_resource_group.gl_rg.location
  size                  = "Standard_B2s"
  admin_username        = "ubuntu"
  network_interface_ids = [azurerm_network_interface.gl_nic.id]

  admin_ssh_key {
    username   = "ubuntu"
    public_key = tls_private_key.gl_rsa_key.public_key_openssh
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
    disk_size_gb         = 30
  }

  source_image_id = data.azurerm_image.gitlab_ce.id

  depends_on = [
    azurerm_network_interface.gl_nic,
    tls_private_key.gl_rsa_key,
    azurerm_public_ip.gl_pip
  ]
}
