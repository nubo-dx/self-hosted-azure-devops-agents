resource "random_password" "azda-username" {
  provider         = random
  length           = 19
  special          = true
  override_special = "-_"
}

resource "random_password" "azda-password" {
  provider = random
  length   = 72
  special  = true
}

data "azurerm_shared_image_version" "azda-image" {
  name                = "1.0.0"
  image_name          = var.definition_name
  gallery_name        = var.gallery_name
  resource_group_name = var.image_rg_name
}

resource "azurerm_linux_virtual_machine_scale_set" "azda-vmss" {
  name                            = var.vmss_name
  computer_name_prefix            = "azd-agent"
  resource_group_name             = azurerm_resource_group.rg.name
  location                        = "France Central"
  sku                             = "Standard_B2s"
  instances                       = 1
  disable_password_authentication = false
  admin_password                  = random_password.azda-password.result
  admin_username                  = random_password.azda-username.result
  overprovision                   = false
  single_placement_group          = false
  upgrade_mode                    = "Automatic"

  source_image_id = data.azurerm_shared_image_version.azda-image.id

  os_disk {
    storage_account_type = "Standard_LRS"
    caching              = "ReadWrite"
  }

  automatic_os_upgrade_policy {
    disable_automatic_rollback  = false
    enable_automatic_os_upgrade = false
  }

  network_interface {
    name    = "nic"
    primary = true

    ip_configuration {
      name      = "default"
      primary   = true
      version   = "IPv4"
    }
  }
}
