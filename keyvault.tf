data "azurerm_client_config" "current" {
}

resource "random_string" "name" {
  length  = 13
  lower   = true
  number  = true
  special = false
  upper   = true
}

resource "azurerm_key_vault" "autoioc-kv" {
  name                        = "autoioc-kv-${random_string.name.result}"
  location                    = azurerm_resource_group.autoioc-rg.location
  resource_group_name         = azurerm_resource_group.autoioc-rg.name
  enabled_for_disk_encryption = true
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days  = 7
  purge_protection_enabled    = false
  sku_name                    = "standard"

  tags = var.all-tags

}

resource "azurerm_key_vault_access_policy" "kv-ap-client" {
  key_vault_id = azurerm_key_vault.autoioc-kv.id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = data.azurerm_client_config.current.object_id

  secret_permissions = [
    "Backup", "Delete", "get", "list", "purge", "recover", "restore", "set",
  ]
}

resource "azurerm_key_vault_access_policy" "kv-ap-vm" {
  key_vault_id = azurerm_key_vault.autoioc-kv.id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = azurerm_linux_virtual_machine.autoioc-vm.identity[0].principal_id

  secret_permissions = [
    "get", "list",
  ]
}

resource "random_password" "value" {
  length  = 16
  special = true

  depends_on = [
    azurerm_key_vault_access_policy.kv-ap-client
  ]
}

resource "azurerm_key_vault_secret" "secret-test23" {
  name         = "secret-test23"
  value        = random_password.value.result
  key_vault_id = azurerm_key_vault.autoioc-kv.id

  depends_on = [
    azurerm_key_vault_access_policy.kv-ap-client
  ]
}