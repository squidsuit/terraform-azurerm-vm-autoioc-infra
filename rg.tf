resource "azurerm_resource_group" "autoioc-rg" {
  name     = "rg-${var.application-name}-${var.environment}-${var.region}"
  location = var.region

  tags = var.all-tags

}