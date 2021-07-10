resource "azurerm_linux_virtual_machine" "autoioc-vm" {
  name                = "vm-${var.application-name}-${var.environment}-${var.region}"
  resource_group_name = azurerm_resource_group.autoioc-rg.name
  location            = azurerm_resource_group.autoioc-rg.location
  size                = "Standard_DS1_V2"
  admin_username      = var.vmadmin

  // TODO: Figure out the best way to get a remnux image here
  # source_image_id = data.azurerm_image.remnux-image.id

  network_interface_ids = [
    azurerm_network_interface.nic.id,
  ]

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }

  admin_ssh_key {
    username   = "azureuser"
    public_key = file("~/.ssh/id_rsa.pub")
  }

  os_disk {
    caching              = "ReadOnly"
    storage_account_type = "Standard_LRS"

    diff_disk_settings {
      option = "Local"
    }
  }

  identity {
    type = "SystemAssigned"
  }

  tags = var.all-tags

}

data "azurerm_role_definition" "reader" {
  name = "Reader"
}

data "azurerm_role_definition" "contributor" {
  name = "Contributor"
}

resource "azurerm_role_assignment" "kv" {
  scope              = azurerm_key_vault.autoioc-kv.id
  role_definition_id = data.azurerm_role_definition.reader.id
  principal_id       = azurerm_linux_virtual_machine.autoioc-vm.identity[0].principal_id
}

resource "azurerm_role_assignment" "sa" {
  scope              = azurerm_storage_account.autoioc-sa.id
  role_definition_id = data.azurerm_role_definition.contributor.id
  principal_id       = azurerm_linux_virtual_machine.autoioc-vm.identity[0].principal_id
}

resource "azurerm_role_assignment" "vm" {
  scope              = azurerm_linux_virtual_machine.autoioc-vm.id
  role_definition_id = data.azurerm_role_definition.contributor.id
  principal_id       = azurerm_linux_virtual_machine.autoioc-vm.identity[0].principal_id
}