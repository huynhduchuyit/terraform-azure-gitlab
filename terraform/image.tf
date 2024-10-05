data "azurerm_image" "gitlab_ce" {
  name                = "gitlab-ce"
  resource_group_name = data.azurerm_resource_group.gl_rg.name
}
