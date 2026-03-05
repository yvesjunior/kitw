# =============================================================================
# Managed disks – OS and data disks for Kiteworks VMs (as resources)
# These disks are linked to VMs in resources-vms.tf via storage_os_disk and
# storage_data_disk (managed_disk_id). See outputs vm_disk_links and disk_to_vm.
# Adjust names/sizes from Azure; create_option = "Empty" for import compatibility
# =============================================================================

locals {
  loc_central = "canadacentral"
  loc_east    = "canadaeast"
}

# ----- Kiteworks-EP -----
# Each disk depends on its VM’s resource group (see DEPENDENCIES.md for full graph).
resource "azurerm_managed_disk" "ep_vm01_os" {
  name                 = "EPPD1VMKWMFT01_OsDisk_1_ed076aa1a20543538cd0cb124bcf9801"
  resource_group_name  = azurerm_resource_group.ep.name
  location             = local.loc_east
  storage_account_type = "Premium_LRS"
  create_option        = "Empty"
  disk_size_gb         = 140
  depends_on           = [azurerm_resource_group.ep]
}
resource "azurerm_managed_disk" "ep_vm01_data1" {
  name                 = "EPPD1VMKWMFT01_lun_0_2_c35b9f8920644fc5b69a72227d0f2049"
  resource_group_name  = azurerm_resource_group.ep.name
  location             = local.loc_east
  storage_account_type = "Premium_LRS"
  create_option        = "Empty"
  disk_size_gb         = 20
  depends_on           = [azurerm_resource_group.ep]
}
resource "azurerm_managed_disk" "ep_vm01_data2" {
  name                 = "EPPD1VMKWMFT01-lun_datadisk_2"
  resource_group_name  = azurerm_resource_group.ep.name
  location             = local.loc_east
  storage_account_type = "Premium_LRS"
  create_option        = "Empty"
  disk_size_gb         = 64
  depends_on           = [azurerm_resource_group.ep]
}
resource "azurerm_managed_disk" "ep_vm02_os" {
  name                 = "EPPD1VMKWMFT02_OsDisk_1_e9d22c275cbb48fd8cca82557a37a083"
  resource_group_name  = azurerm_resource_group.ep.name
  location             = local.loc_east
  storage_account_type = "Premium_LRS"
  create_option        = "Empty"
  disk_size_gb         = 128
  depends_on           = [azurerm_resource_group.ep]
}
resource "azurerm_managed_disk" "ep_vm02_data1" {
  name                 = "EPPD1VMKWMFT02_lun_0_2_4a43a49d5825416596f439b67acfc23e"
  resource_group_name  = azurerm_resource_group.ep.name
  location             = local.loc_east
  storage_account_type = "Premium_LRS"
  create_option        = "Empty"
  disk_size_gb         = 64
  depends_on           = [azurerm_resource_group.ep]
}

# ----- Kiteworks-EP (3rd VM) -----
resource "azurerm_managed_disk" "ep_vm03_os" {
  name                 = "EPPD1VM1KWMFT1_OsDisk_1"
  resource_group_name  = azurerm_resource_group.ep.name
  location             = local.loc_east
  storage_account_type = "Premium_LRS"
  create_option        = "Empty"
  disk_size_gb         = 128
  depends_on           = [azurerm_resource_group.ep]
}
resource "azurerm_managed_disk" "ep_vm03_data1" {
  name                 = "EPPD1VM1KWMFT1_lun_0"
  resource_group_name  = azurerm_resource_group.ep.name
  location             = local.loc_east
  storage_account_type = "Premium_LRS"
  create_option        = "Empty"
  disk_size_gb         = 64
  depends_on           = [azurerm_resource_group.ep]
}

# ----- Kiteworks-ES -----
resource "azurerm_managed_disk" "es_vm01_os" {
  name                 = "ESUT1VMKWMFT01_OsDisk_1"
  resource_group_name  = azurerm_resource_group.es.name
  location             = local.loc_east
  storage_account_type = "Premium_LRS"
  create_option        = "Empty"
  disk_size_gb         = 128
  depends_on           = [azurerm_resource_group.es]
}
resource "azurerm_managed_disk" "es_vm01_data1" {
  name                 = "ESUT1VMKWMFT01_lun_0"
  resource_group_name  = azurerm_resource_group.es.name
  location             = local.loc_east
  storage_account_type = "Premium_LRS"
  create_option        = "Empty"
  disk_size_gb         = 64
  depends_on           = [azurerm_resource_group.es]
}
resource "azurerm_managed_disk" "es_vm02_os" {
  name                 = "EPPD1KWMFT02_OsDisk_1"
  resource_group_name  = azurerm_resource_group.es.name
  location             = local.loc_east
  storage_account_type = "Premium_LRS"
  create_option        = "Empty"
  disk_size_gb         = 128
  depends_on           = [azurerm_resource_group.es]
}
resource "azurerm_managed_disk" "es_vm02_data1" {
  name                 = "EPPD1KWMFT02_lun_0"
  resource_group_name  = azurerm_resource_group.es.name
  location             = local.loc_east
  storage_account_type = "Premium_LRS"
  create_option        = "Empty"
  disk_size_gb         = 64
  depends_on           = [azurerm_resource_group.es]
}
resource "azurerm_managed_disk" "es_vm03_os" {
  name                 = "ESUT1KWMFT01_OsDisk_1"
  resource_group_name  = azurerm_resource_group.es.name
  location             = local.loc_east
  storage_account_type = "Premium_LRS"
  create_option        = "Empty"
  disk_size_gb         = 128
  depends_on           = [azurerm_resource_group.es]
}
resource "azurerm_managed_disk" "es_vm03_data1" {
  name                 = "ESUT1KWMFT01_lun_0"
  resource_group_name  = azurerm_resource_group.es.name
  location             = local.loc_east
  storage_account_type = "Premium_LRS"
  create_option        = "Empty"
  disk_size_gb         = 64
  depends_on           = [azurerm_resource_group.es]
}

# ----- Kiteworks-CP -----
resource "azurerm_managed_disk" "cp_vm01_os" {
  name                 = "CPPD1VMKWMFT01_OsDisk_1"
  resource_group_name  = azurerm_resource_group.cp.name
  location             = local.loc_central
  storage_account_type = "Premium_LRS"
  create_option        = "Empty"
  disk_size_gb         = 128
  depends_on           = [azurerm_resource_group.cp]
}
resource "azurerm_managed_disk" "cp_vm01_data1" {
  name                 = "CPPD1VMKWMFT01_lun_0"
  resource_group_name  = azurerm_resource_group.cp.name
  location             = local.loc_central
  storage_account_type = "Premium_LRS"
  create_option        = "Empty"
  disk_size_gb         = 64
  depends_on           = [azurerm_resource_group.cp]
}

# ----- Kiteworks-CS -----
resource "azurerm_managed_disk" "cs_vm01_os" {
  name                 = "CSUT1VMKWMFT01_OsDisk_1"
  resource_group_name  = azurerm_resource_group.cs.name
  location             = local.loc_central
  storage_account_type = "Premium_LRS"
  create_option        = "Empty"
  disk_size_gb         = 128
  depends_on           = [azurerm_resource_group.cs]
}
resource "azurerm_managed_disk" "cs_vm01_data1" {
  name                 = "CSUT1VMKWMFT01_lun_0"
  resource_group_name  = azurerm_resource_group.cs.name
  location             = local.loc_central
  storage_account_type = "Premium_LRS"
  create_option        = "Empty"
  disk_size_gb         = 64
  depends_on           = [azurerm_resource_group.cs]
}
resource "azurerm_managed_disk" "cs_vm02_os" {
  name                 = "CPPD1KWMFT01_OsDisk_1"
  resource_group_name  = azurerm_resource_group.cs.name
  location             = local.loc_central
  storage_account_type = "Premium_LRS"
  create_option        = "Empty"
  disk_size_gb         = 128
  depends_on           = [azurerm_resource_group.cs]
}
resource "azurerm_managed_disk" "cs_vm02_data1" {
  name                 = "CPPD1KWMFT01_lun_0"
  resource_group_name  = azurerm_resource_group.cs.name
  location             = local.loc_central
  storage_account_type = "Premium_LRS"
  create_option        = "Empty"
  disk_size_gb         = 64
  depends_on           = [azurerm_resource_group.cs]
}
