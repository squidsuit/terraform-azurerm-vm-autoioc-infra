# rg
output "rg-id" {
  description = "Resource Group ID"
  value       = azurerm_resource_group.autoioc-rg.id
}

output "rg-name" {
  description = "Resource Group name"
  value       = azurerm_resource_group.autoioc-rg.name
}

output "rg-location" {
  description = "Resource Group location"
  value       = azurerm_resource_group.autoioc-rg.location
}

# vm
output "vm-id" {
  description = "Auto-IOC VM ID"
  value       = azurerm_linux_virtual_machine.autoioc-vm.id
}

output "vm-msi-id" {
  description = "Principal ID for the SystemManaged MSI assigned to the Auto-IOC VM"
  value       = azurerm_linux_virtual_machine.autoioc-vm.identity[0].principal_id
}

output "vm-priv-ip" {
  description = "Auto-IOC VM private IP"
  value       = azurerm_linux_virtual_machine.autoioc-vm.private_ip_address
}

output "vm-location" {
  description = "Auto-IOC VM region location"
  value       = azurerm_linux_virtual_machine.autoioc-vm.location
}

output "vm-rg" {
  description = "Auto-IOC VM resource group name"
  value       = azurerm_linux_virtual_machine.autoioc-vm.resource_group_name
}

# vnet
output "vnet-name" {
  description = "Auto-IOC vnet name"
  value = azurerm_virtual_network.vnet.name
}

output "vnet-location" {
  description = "Auto-IOC vnet location"
  value = azurerm_virtual_network.vnet.location
}

output "vnet-address-space" {
  description = "Auto-IOC vnet address space"
  value = azurerm_virtual_network.vnet.address_space
}

# subnet
output "subnet-name" {
  description = "Auto-IOC subnet name"
  value = azurerm_subnet.subnet.name
}

output "subnet-vnet-name" {
  description = "Auto-IOC subnet's vnet name"
  value = azurerm_subnet.subnet.virtual_network_name
}

output "subnet-address-prefix" {
  description = "Auto-IOC subnet's address prefix"
  value = azurerm_subnet.subnet.address_prefixes
}

output "subnet-endpoints" {
  description = "Auto-IOC subnet's service endpoints"
  value = azurerm_subnet.subnet.service_endpoints
}

# nic
output "nic-name" {
  description = "Auto-IOC vnet's nic name"
  value = azurerm_network_interface.nic.name
}

output "nic-location" {
  description = "Auto-IOC vnet's nic location"
  value = azurerm_network_interface.nic.location
}

output "nic-ip-config" {
  description = "Auto-IOC vnet's nic ip configuration"
  value = azurerm_network_interface.nic.ip_configuration
}

# storage
output "sa-name" {
  description = "Auto-IOC Storage Account name"
  value       = azurerm_storage_account.autoioc-sa.name
}

output "sa-id" {
  description = "Auto-IOC Storage Account id"
  value       = azurerm_storage_account.autoioc-sa.id
}

output "sa-primary-endpoint" {
  description = "Auto-IOC Storage Account primary endpoint"
  value       = azurerm_storage_account.autoioc-sa.primary_blob_endpoint
}

output "sa-primary-access-key" {
  description = "Auto-IOC Storage Account access key"
  value       = azurerm_storage_account.autoioc-sa.primary_access_key
  sensitive   = true
}

output "sa-rg" {
  description = "Auto-IOC Storage Account resource group name"
  value       = azurerm_storage_account.autoioc-sa.resource_group_name
}

output "sa-location" {
  description = "Auto-IOC Storage Account location"
  value       = azurerm_storage_account.autoioc-sa.location
}

output "sa-tier" {
  description = "Auto-IOC Storage Account account tier"
  value       = azurerm_storage_account.autoioc-sa.account_tier
}

output "sa-public" {
  description = "Auto-IOC Storage Account public access value"
  value       = azurerm_storage_account.autoioc-sa.allow_blob_public_access
}

output "sc-name" {
  description = "Storage container names"
  value = {
    for k, v in azurerm_storage_container.autoioc : k => v.name
  }
}

output "sc-id" {
  description = "Storage container IDs"
  value = {
    for k, v in azurerm_storage_container.autoioc : k => v.id
  }
}

# key vault
output "kv-name" {
  description = "Auto-IOC keyvault name"
  value       = azurerm_key_vault.autoioc-kv.name
}

output "kv-location" {
  description = "Auto-IOC keyvault location"
  value       = azurerm_key_vault.autoioc-kv.location
}

output "kv-rg-name" {
  description = "Auto-IOC keyvault resource group name"
  value       = azurerm_key_vault.autoioc-kv.resource_group_name
}

output "kv-purge" {
  description = "Auto-IOC keyvault purge protection enabled"
  value       = azurerm_key_vault.autoioc-kv.purge_protection_enabled
}

output "kv-soft-del-retention" {
  description = "Auto-IOC keyvault soft delete retention value"
  value       = azurerm_key_vault.autoioc-kv.soft_delete_retention_days
}