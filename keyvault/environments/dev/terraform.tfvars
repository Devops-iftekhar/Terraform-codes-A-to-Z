rg = {
  rg1 = {
    name     = "dev-rg1"
    location = "centralindia"

  }

}
vnet = {
  vnet1 = {
    vnet_name           = "dev-vnet"
    resource_group_name = "dev-rg1"
    location            = "centralindia"
    address_space       = ["10.0.0.0/16"]

  }
}
subnet = {
  subnet1 = {
    name                = "frontend-subnet"
    vnet_name           = "dev-vnet"
    resource_group_name = "dev-rg1"
    address_prefixes    = ["10.0.1.0/24"]
  }
  subnet2 = {
    name                = "Backend-subnet"
    vnet_name           = "dev-vnet"
    resource_group_name = "dev-rg1"
    address_prefixes    = ["10.0.2.0/24"]
  }
  subnet3 = {
    name                = "AzureBastionSubnet"
    vnet_name           = "dev-vnet"
    resource_group_name = "dev-rg1"
    address_prefixes    = ["10.0.3.0/24"]
  }
}

bastion = {
  bastion = {
    pip_name            = "bastion-pip"
    location            = "centralindia"
    resource_group_name = "dev-rg1"
    bastion_subnet_name = "AzureBastionSubnet"
    vnet_name           = "dev-vnet"
    bastion_name        = "dev-bastion"
    ip_config_name      = "bastion-config"
  }
}
vm = {
  vm1 = {
    subnet_name         = "frontend-subnet"
    vnet_name           = "dev-vnet"
    resource_group_name = "dev-rg1"
    nic_name            = "fronend-nic"
    location            = "centralindia"
    vm_name             = "frontend-vm"
    vm_size             = "Standard_D4_v5"
    vm_username         = "vm-username"
    vm_password         = "vm-password"
  }
  vm2 = {
    subnet_name         = "backend-subnet"
    vnet_name           = "dev-vnet"
    resource_group_name = "dev-rg1"
    nic_name            = "backend-nic"
    location            = "centralindia"
    vm_name             = "backend-vm"
    vm_size             = "Standard_D4_v5"
    vm_username         = "vm-username"
    vm_password         = "vm-password"
  }
}


