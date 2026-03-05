# =============================================================================
# Kiteworks resource groups and network interfaces
# =============================================================================

# ----- Resource groups -----
resource "azurerm_resource_group" "cp" {
  name     = "Kiteworks-CP"
  location = "canadacentral"
}

resource "azurerm_resource_group" "cs" {
  name     = "Kiteworks-CS"
  location = "canadacentral"
}

resource "azurerm_resource_group" "ep" {
  name     = "Kiteworks-EP"
  location = "canadaeast"
}

resource "azurerm_resource_group" "es" {
  name     = "Kiteworks-ES"
  location = "canadaeast"
}

# ----- NICs – Canada East (EP: EPRAP-SUBNET05, ES: ESRAP-SUBNET05) -----
# Each NIC depends on: RG, Subnet, and Subnet’s route table + NSG associations (whole picture).
resource "azurerm_network_interface" "ep_nic01" {
  name                = "eppd1vmkwmft01791"
  resource_group_name = azurerm_resource_group.ep.name
  location            = "canadaeast"
  ip_configuration {
    name                          = "ipconfig1"
    subnet_id                     = azurerm_subnet.eprap.id
    private_ip_address_allocation = "Dynamic"
  }
  depends_on = [
    azurerm_resource_group.ep,
    azurerm_subnet.eprap,
    azurerm_subnet_route_table_association.eprap,
    azurerm_subnet_network_security_group_association.eprap,
  ]
}
resource "azurerm_network_interface" "ep_nic02" {
  name                = "eppd1vmkwmft02991"
  resource_group_name = azurerm_resource_group.ep.name
  location            = "canadaeast"
  ip_configuration {
    name                          = "ipconfig1"
    subnet_id                     = azurerm_subnet.eprap.id
    private_ip_address_allocation = "Dynamic"
  }
  depends_on = [
    azurerm_resource_group.ep,
    azurerm_subnet.eprap,
    azurerm_subnet_route_table_association.eprap,
    azurerm_subnet_network_security_group_association.eprap,
  ]
}
resource "azurerm_network_interface" "ep_nic03" {
  name                = "eppd1vm1kwmft1868"
  resource_group_name = azurerm_resource_group.ep.name
  location            = "canadaeast"
  ip_configuration {
    name                          = "ipconfig1"
    subnet_id                     = azurerm_subnet.eprap.id
    private_ip_address_allocation = "Dynamic"
  }
  depends_on = [
    azurerm_resource_group.ep,
    azurerm_subnet.eprap,
    azurerm_subnet_route_table_association.eprap,
    azurerm_subnet_network_security_group_association.eprap,
  ]
}

resource "azurerm_network_interface" "es_nic01" {
  name                = "esut1vmkwmft02737"
  resource_group_name = azurerm_resource_group.es.name
  location            = "canadaeast"
  ip_configuration {
    name                          = "ipconfig1"
    subnet_id                     = azurerm_subnet.esrap.id
    private_ip_address_allocation = "Dynamic"
  }
  depends_on = [
    azurerm_resource_group.es,
    azurerm_subnet.esrap,
    azurerm_subnet_route_table_association.esrap,
    azurerm_subnet_network_security_group_association.esrap,
  ]
}
resource "azurerm_network_interface" "es_nic02" {
  name                = "esut1kwmft01971"
  resource_group_name = azurerm_resource_group.es.name
  location            = "canadaeast"
  ip_configuration {
    name                          = "ipconfig1"
    subnet_id                     = azurerm_subnet.esrap.id
    private_ip_address_allocation = "Dynamic"
  }
  depends_on = [
    azurerm_resource_group.es,
    azurerm_subnet.esrap,
    azurerm_subnet_route_table_association.esrap,
    azurerm_subnet_network_security_group_association.esrap,
  ]
}
resource "azurerm_network_interface" "es_nic03" {
  name                = "eppd1kwmft01834"
  resource_group_name = azurerm_resource_group.es.name
  location            = "canadaeast"
  ip_configuration {
    name                          = "ipconfig1"
    subnet_id                     = azurerm_subnet.esrap.id
    private_ip_address_allocation = "Dynamic"
  }
  depends_on = [
    azurerm_resource_group.es,
    azurerm_subnet.esrap,
    azurerm_subnet_route_table_association.esrap,
    azurerm_subnet_network_security_group_association.esrap,
  ]
}

# ----- NICs – Canada Central (CP: CPRAP-SUBNET05, CS: CSRAP-SUBNET05) -----
resource "azurerm_network_interface" "cp_nic01" {
  name                = "cppd1vmkwmft02829"
  resource_group_name = azurerm_resource_group.cp.name
  location            = "canadacentral"
  ip_configuration {
    name                          = "ipconfig1"
    subnet_id                     = azurerm_subnet.cprap.id
    private_ip_address_allocation = "Dynamic"
  }
  depends_on = [
    azurerm_resource_group.cp,
    azurerm_subnet.cprap,
    azurerm_subnet_route_table_association.cprap,
    azurerm_subnet_network_security_group_association.cprap,
  ]
}
resource "azurerm_network_interface" "cs_nic01" {
  name                = "csut1kwmft0192"
  resource_group_name = azurerm_resource_group.cs.name
  location            = "canadacentral"
  ip_configuration {
    name                          = "ipconfig1"
    subnet_id                     = azurerm_subnet.csrap.id
    private_ip_address_allocation = "Dynamic"
  }
  depends_on = [
    azurerm_resource_group.cs,
    azurerm_subnet.csrap,
    azurerm_subnet_route_table_association.csrap,
    azurerm_subnet_network_security_group_association.csrap,
  ]
}
resource "azurerm_network_interface" "cs_nic02" {
  name                = "cppd1kwmft01595"
  resource_group_name = azurerm_resource_group.cs.name
  location            = "canadacentral"
  ip_configuration {
    name                          = "ipconfig1"
    subnet_id                     = azurerm_subnet.csrap.id
    private_ip_address_allocation = "Dynamic"
  }
  depends_on = [
    azurerm_resource_group.cs,
    azurerm_subnet.csrap,
    azurerm_subnet_route_table_association.csrap,
    azurerm_subnet_network_security_group_association.csrap,
  ]
}
