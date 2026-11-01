module "resource_group" {
  source = "../../module/azurerm_rg"
  rg     = var.rg

}
module "virtual_network" {
  source = "../../module/azurerm_virtual_network"
  vnet   = var.vnet
  depends_on = [ module.resource_group ]

}
module "subnet" {
  source = "../../module/azurerm_subnet"
  subnet = var.subnet
  depends_on = [ module.virtual_network ]

}
module "bastion" {
  source  = "../../module/azurerm_bastion"
  bastion = var.bastion
  depends_on = [ module.resource_group,module.subnet ]

}
module "vm" {
  source = "../../module/azurerm_vm"
  vm     = var.vm
  depends_on = [ module.subnet ]

}