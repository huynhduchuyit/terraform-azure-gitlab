source "azure-arm" "gitlab-ce" {
  managed_image_name                = "gitlab-ce"
  managed_image_resource_group_name = "gitlab-ce"
  build_resource_group_name         = "gitlab-ce"
  vm_size                           = "Standard_B2s"

  os_type         = "Linux"
  image_offer     = "ubuntu-24_04-lts"
  image_publisher = "canonical"
  image_sku       = "server-gen1"

  use_azure_cli_auth = true
}

build {
  sources = ["source.azure-arm.gitlab-ce"]

  provisioner "shell" {
    inline = [
      "sudo apt update",
      "sudo apt upgrade -y"
    ]
  }

  provisioner "file" {
    source      = "./install-gitlab-ce.sh"
    destination = "/tmp/"
  }

  provisioner "shell" {
    inline = [
      "bash /tmp/install-gitlab-ce.sh"
    ]
  }
}
