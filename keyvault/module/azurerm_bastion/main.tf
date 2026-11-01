resource "azurerm_public_ip" "pips" {
    for_each = var.bastion
  name                = each.value.pip_name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name
  allocation_method   = "Static"
  sku                 = "Standard"
}
data "azurerm_subnet" "subnet" {
  for_each             = var.bastion
  name                 = each.value.bastion_subnet_name
  virtual_network_name = each.value.vnet_name
  resource_group_name  = each.value.resource_group_name
}

resource "azurerm_bastion_host" "bastions" {
    for_each = var.bastion
  name                = each.value.bastion_name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name

  ip_configuration {
    name                 = "configuration"
    subnet_id            = data.azurerm_subnet.subnet[each.key].id
    public_ip_address_id = azurerm_public_ip.pips[each.key].id
  }
}