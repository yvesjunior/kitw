# =============================================================================
# Outputs – subscription, network, RGs, NICs, VMs
# =============================================================================

output "subscription_id" {
  value = data.azurerm_subscription.current.subscription_id
}
output "subscription_display_name" {
  value = data.azurerm_subscription.current.display_name
}

output "vnet_east_id" {
  value = azurerm_virtual_network.east.id
}
output "vnet_central_id" {
  value = azurerm_virtual_network.central.id
}
output "subnet_eprap_id" {
  value = azurerm_subnet.eprap.id
}
output "subnet_esrap_id" {
  value = azurerm_subnet.esrap.id
}
output "subnet_cprap_id" {
  value = azurerm_subnet.cprap.id
}
output "subnet_csrap_id" {
  value = azurerm_subnet.csrap.id
}
output "route_table_eprap_id" {
  value = azurerm_route_table.eprap.id
}
output "route_table_esrap_id" {
  value = azurerm_route_table.esrap.id
}
output "route_table_cprap_id" {
  value = azurerm_route_table.cprap.id
}
output "route_table_csrap_id" {
  value = azurerm_route_table.csrap.id
}
output "nsg_eprap_id" {
  value = azurerm_network_security_group.eprap.id
}
output "nsg_esrap_id" {
  value = azurerm_network_security_group.esrap.id
}
output "nsg_cprap_id" {
  value = azurerm_network_security_group.cprap.id
}
output "nsg_csrap_id" {
  value = azurerm_network_security_group.csrap.id
}

output "resource_group_ids" {
  value = {
    cp = azurerm_resource_group.cp.id
    cs = azurerm_resource_group.cs.id
    ep = azurerm_resource_group.ep.id
    es = azurerm_resource_group.es.id
  }
}
output "nic_ids" {
  value = {
    ep = [azurerm_network_interface.ep_nic01.id, azurerm_network_interface.ep_nic02.id, azurerm_network_interface.ep_nic03.id]
    es = [azurerm_network_interface.es_nic01.id, azurerm_network_interface.es_nic02.id, azurerm_network_interface.es_nic03.id]
    cp = [azurerm_network_interface.cp_nic01.id]
    cs = [azurerm_network_interface.cs_nic01.id, azurerm_network_interface.cs_nic02.id]
  }
}
output "vm_ids" {
  value = {
    ep = [azurerm_virtual_machine.ep_vm01.id, azurerm_virtual_machine.ep_vm02.id]
  }
}

# -----------------------------------------------------------------------------
# VM ↔ disk linkage (each VM lists its OS disk + data disks)
# -----------------------------------------------------------------------------
output "vm_disk_links" {
  description = "Each VM and its linked disks (OS + data). Disks are attached via storage_os_disk / storage_data_disk in resources-vms.tf."
  value = {
    EPPD1VMKWMFT01 = {
      vm_id        = azurerm_virtual_machine.ep_vm01.id
      os_disk_id   = azurerm_managed_disk.ep_vm01_os.id
      os_disk_name = azurerm_managed_disk.ep_vm01_os.name
      data_disks = [
        { id = azurerm_managed_disk.ep_vm01_data1.id, name = azurerm_managed_disk.ep_vm01_data1.name, lun = 0 },
        { id = azurerm_managed_disk.ep_vm01_data2.id, name = azurerm_managed_disk.ep_vm01_data2.name, lun = 1 },
      ]
    }
    EPPD1VMKWMFT02 = {
      vm_id        = azurerm_virtual_machine.ep_vm02.id
      os_disk_id   = azurerm_managed_disk.ep_vm02_os.id
      os_disk_name = azurerm_managed_disk.ep_vm02_os.name
      data_disks = [
        { id = azurerm_managed_disk.ep_vm02_data1.id, name = azurerm_managed_disk.ep_vm02_data1.name, lun = 0 },
      ]
    }
  }
}

output "disk_to_vm" {
  description = "Each managed disk and the VM it is linked to (via VM storage_os_disk / storage_data_disk)."
  value = {
    (azurerm_managed_disk.ep_vm01_os.name)     = "EPPD1VMKWMFT01 (OS)"
    (azurerm_managed_disk.ep_vm01_data1.name)  = "EPPD1VMKWMFT01 (data LUN 0)"
    (azurerm_managed_disk.ep_vm01_data2.name)  = "EPPD1VMKWMFT01 (data LUN 1)"
    (azurerm_managed_disk.ep_vm02_os.name)     = "EPPD1VMKWMFT02 (OS)"
    (azurerm_managed_disk.ep_vm02_data1.name)  = "EPPD1VMKWMFT02 (data LUN 0)"
  }
}
