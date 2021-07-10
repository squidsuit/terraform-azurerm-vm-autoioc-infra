resource "random_string" "sa-name" {
  length  = 17
  lower   = true
  number  = true
  special = false
  upper   = false
}

resource "azurerm_storage_account" "autoioc-sa" {
  name                     = "autoioc${random_string.sa-name.result}"
  resource_group_name      = azurerm_resource_group.autoioc-rg.name
  location                 = azurerm_resource_group.autoioc-rg.location
  account_tier             = "Standard"
  account_replication_type = "GRS"

  tags = var.all-tags

}

resource "azurerm_storage_container" "autoioc" {
  for_each = {
    logs    = "log-outputs"
    samples = "autoioc-samples"
  }

  name                  = each.value
  storage_account_name  = azurerm_storage_account.autoioc-sa.name
  container_access_type = "private"

}