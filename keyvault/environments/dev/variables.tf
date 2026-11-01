variable "rg" {
  type = map(object({
    name     = string
    location = string
  }))
}

variable "vnet" {
  type = map(object({
    vnet_name           = string
    resource_group_name = string
    location            = string
    address_space       = list(string)
  }))
}
variable "subnet" {
  type = map(any)

}
variable "vm" {
  type = map(any)

}
variable "bastion" {
  type = map(any)

}
