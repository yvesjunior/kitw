# =============================================================================
# Kiteworks VMs – Linux (attach existing NICs and managed disks)
# =============================================================================

# ----- Kiteworks-EP (Canada East) -----
resource "azurerm_virtual_machine" "ep_vm01" {
  name                  = "EPPD1VMKWMFT01"
  resource_group_name   = azurerm_resource_group.ep.name
  location              = "canadaeast"
  vm_size               = "Standard_D16s_v3"
  network_interface_ids = [azurerm_network_interface.ep_nic01.id]
  storage_os_disk {
    name              = azurerm_managed_disk.ep_vm01_os.name
    managed_disk_id   = azurerm_managed_disk.ep_vm01_os.id
    create_option     = "Attach"
    os_type           = "Linux"
  }
  storage_data_disk {
    name            = azurerm_managed_disk.ep_vm01_data1.name
    managed_disk_id = azurerm_managed_disk.ep_vm01_data1.id
    create_option   = "Attach"
    lun             = 0
  }
  storage_data_disk {
    name            = azurerm_managed_disk.ep_vm01_data2.name
    managed_disk_id = azurerm_managed_disk.ep_vm01_data2.id
    create_option   = "Attach"
    lun             = 1
  }
  delete_os_disk_on_termination    = false
  delete_data_disks_on_termination = false

  depends_on = [
    azurerm_resource_group.ep,
    azurerm_network_interface.ep_nic01,
    azurerm_managed_disk.ep_vm01_os,
    azurerm_managed_disk.ep_vm01_data1,
    azurerm_managed_disk.ep_vm01_data2,
  ]
}

resource "azurerm_virtual_machine" "ep_vm02" {
  name                  = "EPPD1VMKWMFT02"
  resource_group_name   = azurerm_resource_group.ep.name
  location              = "canadaeast"
  vm_size               = "Standard_F8s_v2"
  network_interface_ids = [azurerm_network_interface.ep_nic02.id]
  storage_os_disk {
    name              = azurerm_managed_disk.ep_vm02_os.name
    managed_disk_id   = azurerm_managed_disk.ep_vm02_os.id
    create_option     = "Attach"
    os_type           = "Linux"
  }
  storage_data_disk {
    name            = azurerm_managed_disk.ep_vm02_data1.name
    managed_disk_id = azurerm_managed_disk.ep_vm02_data1.id
    create_option   = "Attach"
    lun             = 0
  }
  delete_os_disk_on_termination    = false
  delete_data_disks_on_termination = false

  depends_on = [
    azurerm_resource_group.ep,
    azurerm_network_interface.ep_nic02,
    azurerm_managed_disk.ep_vm02_os,
    azurerm_managed_disk.ep_vm02_data1,
  ]
}

# ----- Add remaining VMs (EPPD1KWMFT02, EPPD1VMKWMFT03, ES*, CP*, CS*) with their NICs and disks -----
