resource "azurerm_shared_image" "definition" {
  name                = var.definition_name
  gallery_name        = data.azurerm_shared_image_gallery.sig.name
  resource_group_name = data.azurerm_resource_group.rg.name
  location            = data.azurerm_resource_group.rg.location
  os_type             = "Linux" # ou "Windows"

  identifier {
    publisher = "canonical" # ou "MicrosoftWindowsServer"
    offer     = "0001-com-ubuntu-server-jammy" # ou "WindowsServer"
    sku       = "22_04-lts" # ou "2022-Datacenter"
  }
}