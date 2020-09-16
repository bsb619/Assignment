
# this data source to access information about an existing Resource Group. 
data "azurerm_resource_group" "main_rg" {
  name = var.resource_group_name
}

# this data source to access information about an existing VNet Resource Group.
data "azurerm_resource_group" "vnetshared_rg" {
  name = var.vnet_resource_group_name
}

# this data source to access information about an existing virtual network.
data "azurerm_virtual_network" "vnet" {
  name                = var.vnet_name
  resource_group_name = data.azurerm_resource_group.vnetshared_rg.name
}

# this data source to access information about an existing subnet.
data "azurerm_subnet" "subnet" {
  name                 = var.subnet_name
  resource_group_name  = data.azurerm_resource_group.vnetshared_rg.name
  virtual_network_name = data.azurerm_virtual_network.vnet.name
}

# create a network interface for the VM
resource "azurerm_network_interface" "nic" {
  name                = var.nic_name
  count               = var.vm_count
  location            = var.location
  resource_group_name = data.azurerm_resource_group.main_rg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = data.azurerm_subnet.subnet.id
    private_ip_address_allocation = "dynamic"
  }
}

# create a windows virtual machine
resource "azurerm_virtual_machine" "vm" {
  count                 = var.vm_count
  name                  = var.vm_name
  location              = var.location
  resource_group_name   = data.azurerm_resource_group.main_rg.name
  network_interface_ids = [element(azurerm_network_interface.nic.*.id, count.index)]
  vm_size               = var.size

  # this image from shared repository will be used for vm deployment  
  storage_image_reference {
    id = var.image_reference_id
  }

  storage_os_disk {
    name              = var.vm_name
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = var.storage_account_type
  }
  os_profile {
    computer_name  = var.vm_name
    admin_username = var.administrator_login
    admin_password = var.administrator_password
  }
  os_profile_windows_config {
    provision_vm_agent = true
  }
  boot_diagnostics {
    enabled     = true
    storage_uri = var.boot_diagnostics
  }

  # tags for the virtual machine
  tags = {
    Environment = var.environment
  }
}
