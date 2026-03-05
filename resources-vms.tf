# =============================================================================
# Kiteworks VMs – Linux (attach existing NICs and managed disks)
# Disks are linked to VMs via storage_os_disk.managed_disk_id and
# storage_data_disk[].managed_disk_id (see resources-disks.tf for disk definitions).
# =============================================================================

# ----- Kiteworks-EP (Canada East) -----
resource "azurerm_virtual_machine" "ep_vm01" {
  name                  = "EPPD1VMKWMFT01"
  resource_group_name   = azurerm_resource_group.ep.name
  location              = "canadaeast"
  vm_size               = "Standard_D16s_v3"
  network_interface_ids = [azurerm_network_interface.ep_nic01.id]
  # OS disk link
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

# ----- Kiteworks-EP (3rd VM) -----
resource "azurerm_virtual_machine" "ep_vm03" {
  name                  = "EPPD1VM1KWMFT1"
  resource_group_name   = azurerm_resource_group.ep.name
  location              = "canadaeast"
  vm_size               = "Standard_D8s_v5"
  network_interface_ids = [azurerm_network_interface.ep_nic03.id]
  storage_os_disk {
    name              = azurerm_managed_disk.ep_vm03_os.name
    managed_disk_id   = azurerm_managed_disk.ep_vm03_os.id
    create_option     = "Attach"
    os_type           = "Linux"
  }
  storage_data_disk {
    name            = azurerm_managed_disk.ep_vm03_data1.name
    managed_disk_id = azurerm_managed_disk.ep_vm03_data1.id
    create_option   = "Attach"
    lun             = 0
  }
  delete_os_disk_on_termination    = false
  delete_data_disks_on_termination  = false
  depends_on = [
    azurerm_resource_group.ep,
    azurerm_network_interface.ep_nic03,
    azurerm_managed_disk.ep_vm03_os,
    azurerm_managed_disk.ep_vm03_data1,
  ]
}

# ----- Kiteworks-ES (Canada East) -----
resource "azurerm_virtual_machine" "es_vm01" {
  name                  = "ESUT1VMKWMFT01"
  resource_group_name   = azurerm_resource_group.es.name
  location              = "canadaeast"
  vm_size               = "Standard_D8s_v3"
  network_interface_ids = [azurerm_network_interface.es_nic01.id]
  storage_os_disk {
    name              = azurerm_managed_disk.es_vm01_os.name
    managed_disk_id   = azurerm_managed_disk.es_vm01_os.id
    create_option     = "Attach"
    os_type           = "Linux"
  }
  storage_data_disk {
    name            = azurerm_managed_disk.es_vm01_data1.name
    managed_disk_id = azurerm_managed_disk.es_vm01_data1.id
    create_option   = "Attach"
    lun             = 0
  }
  delete_os_disk_on_termination    = false
  delete_data_disks_on_termination = false
  depends_on = [
    azurerm_resource_group.es,
    azurerm_network_interface.es_nic01,
    azurerm_managed_disk.es_vm01_os,
    azurerm_managed_disk.es_vm01_data1,
  ]
}
resource "azurerm_virtual_machine" "es_vm02" {
  name                  = "EPPD1KWMFT02"
  resource_group_name   = azurerm_resource_group.es.name
  location              = "canadaeast"
  vm_size               = "Standard_D16s_v3"
  network_interface_ids = [azurerm_network_interface.es_nic02.id]
  storage_os_disk {
    name              = azurerm_managed_disk.es_vm02_os.name
    managed_disk_id   = azurerm_managed_disk.es_vm02_os.id
    create_option     = "Attach"
    os_type           = "Linux"
  }
  storage_data_disk {
    name            = azurerm_managed_disk.es_vm02_data1.name
    managed_disk_id = azurerm_managed_disk.es_vm02_data1.id
    create_option   = "Attach"
    lun             = 0
  }
  delete_os_disk_on_termination    = false
  delete_data_disks_on_termination = false
  depends_on = [
    azurerm_resource_group.es,
    azurerm_network_interface.es_nic02,
    azurerm_managed_disk.es_vm02_os,
    azurerm_managed_disk.es_vm02_data1,
  ]
}
resource "azurerm_virtual_machine" "es_vm03" {
  name                  = "ESUT1KWMFT01"
  resource_group_name   = azurerm_resource_group.es.name
  location              = "canadaeast"
  vm_size               = "Standard_F8s_v2"
  network_interface_ids = [azurerm_network_interface.es_nic03.id]
  storage_os_disk {
    name              = azurerm_managed_disk.es_vm03_os.name
    managed_disk_id   = azurerm_managed_disk.es_vm03_os.id
    create_option     = "Attach"
    os_type           = "Linux"
  }
  storage_data_disk {
    name            = azurerm_managed_disk.es_vm03_data1.name
    managed_disk_id = azurerm_managed_disk.es_vm03_data1.id
    create_option   = "Attach"
    lun             = 0
  }
  delete_os_disk_on_termination    = false
  delete_data_disks_on_termination = false
  depends_on = [
    azurerm_resource_group.es,
    azurerm_network_interface.es_nic03,
    azurerm_managed_disk.es_vm03_os,
    azurerm_managed_disk.es_vm03_data1,
  ]
}

# ----- Kiteworks-CP (Canada Central) -----
resource "azurerm_virtual_machine" "cp_vm01" {
  name                  = "CPPD1VMKWMFT01"
  resource_group_name   = azurerm_resource_group.cp.name
  location              = "canadacentral"
  vm_size               = "Standard_D8s_v5"
  network_interface_ids = [azurerm_network_interface.cp_nic01.id]
  storage_os_disk {
    name              = azurerm_managed_disk.cp_vm01_os.name
    managed_disk_id   = azurerm_managed_disk.cp_vm01_os.id
    create_option     = "Attach"
    os_type           = "Linux"
  }
  storage_data_disk {
    name            = azurerm_managed_disk.cp_vm01_data1.name
    managed_disk_id = azurerm_managed_disk.cp_vm01_data1.id
    create_option   = "Attach"
    lun             = 0
  }
  delete_os_disk_on_termination    = false
  delete_data_disks_on_termination = false
  depends_on = [
    azurerm_resource_group.cp,
    azurerm_network_interface.cp_nic01,
    azurerm_managed_disk.cp_vm01_os,
    azurerm_managed_disk.cp_vm01_data1,
  ]
}

# ----- Kiteworks-CS (Canada Central) -----
resource "azurerm_virtual_machine" "cs_vm01" {
  name                  = "CSUT1VMKWMFT01"
  resource_group_name   = azurerm_resource_group.cs.name
  location              = "canadacentral"
  vm_size               = "Standard_D8s_v3"
  network_interface_ids = [azurerm_network_interface.cs_nic01.id]
  storage_os_disk {
    name              = azurerm_managed_disk.cs_vm01_os.name
    managed_disk_id   = azurerm_managed_disk.cs_vm01_os.id
    create_option     = "Attach"
    os_type           = "Linux"
  }
  storage_data_disk {
    name            = azurerm_managed_disk.cs_vm01_data1.name
    managed_disk_id = azurerm_managed_disk.cs_vm01_data1.id
    create_option   = "Attach"
    lun             = 0
  }
  delete_os_disk_on_termination    = false
  delete_data_disks_on_termination = false
  depends_on = [
    azurerm_resource_group.cs,
    azurerm_network_interface.cs_nic01,
    azurerm_managed_disk.cs_vm01_os,
    azurerm_managed_disk.cs_vm01_data1,
  ]
}
resource "azurerm_virtual_machine" "cs_vm02" {
  name                  = "CPPD1KWMFT01"
  resource_group_name   = azurerm_resource_group.cs.name
  location              = "canadacentral"
  vm_size               = "Standard_F8s_v2"
  network_interface_ids = [azurerm_network_interface.cs_nic02.id]
  storage_os_disk {
    name              = azurerm_managed_disk.cs_vm02_os.name
    managed_disk_id   = azurerm_managed_disk.cs_vm02_os.id
    create_option     = "Attach"
    os_type           = "Linux"
  }
  storage_data_disk {
    name            = azurerm_managed_disk.cs_vm02_data1.name
    managed_disk_id = azurerm_managed_disk.cs_vm02_data1.id
    create_option   = "Attach"
    lun             = 0
  }
  delete_os_disk_on_termination    = false
  delete_data_disks_on_termination = false
  depends_on = [
    azurerm_resource_group.cs,
    azurerm_network_interface.cs_nic02,
    azurerm_managed_disk.cs_vm02_os,
    azurerm_managed_disk.cs_vm02_data1,
  ]
}
