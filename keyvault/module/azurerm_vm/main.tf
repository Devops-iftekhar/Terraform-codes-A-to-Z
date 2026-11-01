data "azurerm_subnet" "subnet" {
  for_each = var.vm
  name = each.value.subnet_name
  resource_group_name = each.value.resource_group_name
  virtual_network_name = each.value.vnet_name
  
}
resource "azurerm_network_interface" "nics" {
  for_each = var.vm
  name                = each.value.nic_name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = data.azurerm_subnet.subnet[each.key].id
    private_ip_address_allocation = "Dynamic"
  }
}
data "azurerm_key_vault" "kv" {
  name                = "lockup"
  resource_group_name = "ado-rg"
}
data "azurerm_key_vault_secret" "vm_username" {
  for_each = var.vm
  name = "vm-username"
  key_vault_id = data.azurerm_key_vault.kv.id
}
data "azurerm_key_vault_secret" "vm_password" {
  for_each = var.vm
  name = "vm-password"
 key_vault_id = data.azurerm_key_vault.kv.id

  
}
resource "azurerm_linux_virtual_machine" "vm" {
    for_each = var.vm
  name = each.value.vm_name
  resource_group_name = each.value.resource_group_name
  location = each.value.location
  size = each.value.vm_size
  
  network_interface_ids = [
    azurerm_network_interface.nics[each.key].id,
  ]
  disable_password_authentication = false
  admin_username = data.azurerm_key_vault_secret.vm_username[each.key].value
  admin_password = data.azurerm_key_vault_secret.vm_password[each.key].value

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
}