resource "azurerm_virtual_network" "vnet" {
  name                = "vnet-${var.application-name}-${var.environment}-${var.region}"
  address_space       = ["10.0.1.0/24"]
  location            = azurerm_resource_group.autoioc-rg.location
  resource_group_name = azurerm_resource_group.autoioc-rg.name

  tags = var.all-tags

}

resource "azurerm_subnet" "subnet" {
  name                 = "subnet-${var.application-name}-${var.environment}-${var.region}"
  resource_group_name  = azurerm_resource_group.autoioc-rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.1.0/24"]
  service_endpoints    = ["Microsoft.KeyVault", "Microsoft.Storage"]

}

resource "azurerm_network_interface" "nic" {
  name                = "nic-${var.application-name}-${var.environment}-${var.region}"
  location            = azurerm_resource_group.autoioc-rg.location
  resource_group_name = azurerm_resource_group.autoioc-rg.name

  tags = var.all-tags

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.public-ip-autoioc-nic.id
  }
}

resource "azurerm_network_interface_security_group_association" "autoioc-nsg-assoc" {
  network_interface_id      = azurerm_network_interface.nic.id
  network_security_group_id = azurerm_network_security_group.autoioc-nsg.id
}

resource "azurerm_public_ip" "public-ip-autoioc-nic" {
  name                = "autoioc-public-ip"
  location            = azurerm_resource_group.autoioc-rg.location
  resource_group_name = azurerm_resource_group.autoioc-rg.name
  allocation_method   = "Static"

  tags = var.all-tags

}

resource "azurerm_network_security_group" "autoioc-nsg" {
  name                = "nsg-${var.application-name}-${var.environment}-${var.region}"
  location            = azurerm_resource_group.autoioc-rg.location
  resource_group_name = azurerm_resource_group.autoioc-rg.name

  tags = var.all-tags

}

resource "azurerm_network_security_rule" "ssh-inbound" {
  name                        = "AllowSSHInbound"
  priority                    = 101
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "22"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.autoioc-rg.name
  network_security_group_name = azurerm_network_security_group.autoioc-nsg.name
}