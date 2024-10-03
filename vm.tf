resource "azurerm_linux_virtual_machine" "gl_vm" {
  name                  = "vm-${var.project}"
  resource_group_name   = azurerm_resource_group.gl_rg.name
  location              = azurerm_resource_group.gl_rg.location
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

  source_image_reference {
    publisher = "canonical"
    offer     = "ubuntu-24_04-lts"
    sku       = "server-gen1"
    version   = "latest"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt update",
      "sudo apt upgrade -y",
      "sudo apt-get install -y curl openssh-server ca-certificates tzdata perl",
      "curl https://packages.gitlab.com/install/repositories/gitlab/gitlab-ce/script.deb.sh | sudo bash",
      "sudo EXTERNAL_URL='http://${azurerm_public_ip.gl_pip.ip_address}' apt-get install -y gitlab-ce"
    ]

    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = tls_private_key.gl_rsa_key.private_key_pem
      host        = azurerm_public_ip.gl_pip.ip_address
    }
  }

  depends_on = [
    azurerm_resource_group.gl_rg,
    azurerm_network_interface.gl_nic,
    tls_private_key.gl_rsa_key
  ]
}
