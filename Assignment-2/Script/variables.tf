variable "resource_group_name" {
  description = "resource group name"
}
variable "vnet_name" {
  description = "name of the azure vnet"
}
variable "nic_name" {
  description = "name of the nic"
}

variable "vm_name" {
  description = "name of the azure vm"
}
variable "subnet_name" {
  description = "name of the azure subnet"
}
variable "ip_address" {
  description = "Private ip address allocation"
  default     = "Dynamic"
}
variable "vnet_resource_group_name" {
  description = "name of the network resource group"
}
variable "location" {
  description = "location of the virtual network"
}
variable "appname" {
  description = "Name of the application (the VM name will be captured based on the apllication)"
}
variable "sub_component_name" {
  description = "Name of the sub-component of an application"
}
variable "administrator_login" {
  description = "Name of the vm administrator login"
  default     = "lowesadmin"
}
variable "administrator_password" {
  description = "Password for the vm administrator login"
  default     = "Password@1234"
}
variable "size" {
  description = "vm size specification"
  default     = "Standard_D2_v2"
}
variable "boot_diagnostics" {
  description = "boot diagnostics trorage for VMs"
}
variable "vm_count" {
  description = "Number of VMs deployment"
  default     = 1
}
variable "image_reference_id" {
  description = "storage_image_reference"
}
variable "storage_account_type" {
  description = "the disk geo replication Locations type"
  default     = "Standard_LRS"
}
variable "environment" {
  description = ""
  default     = "devtest"
}
