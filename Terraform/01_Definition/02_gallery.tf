data "azurerm_shared_image_gallery" "sig" {
  name                = var.gallery_name
  resource_group_name = data.azurerm_resource_group.rg.name
}