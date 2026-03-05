# =============================================================================
# Shared network – VNets, subnets, route tables, NSGs (as resources)
# East: AzureCore-East (Canada East). Central: AzureCore-Cent (Canada Central)
# =============================================================================

# ----- Canada East VNet -----
resource "azurerm_virtual_network" "east" {
  name                = "eastcmhc-vnet01"
  resource_group_name = "AzureCore-East"
  location            = "canadaeast"
  address_space       = ["10.255.0.0/20", "10.255.144.0/21"]
}

# ----- Canada Central VNet -----
resource "azurerm_virtual_network" "central" {
  name                = "centcmhc-vnet01"
  resource_group_name = "AzureCore-Cent"
  location            = "canadacentral"
  address_space       = ["10.254.0.0/20"]
}

# ----- Route tables (East) -----
resource "azurerm_route_table" "eprap" {
  name                = "EPRAP-UDR05"
  resource_group_name = "AzureCore-East"
  location            = "canadaeast"
  route {
    name                   = "Default-Route-To-NVA"
    address_prefix         = "0.0.0.0/0"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = "10.255.2.4" # NVA IP – set to your NVA
  }
}
resource "azurerm_route_table" "esrap" {
  name                = "ESRAP-UDR05"
  resource_group_name = "AzureCore-East"
  location            = "canadaeast"
  route {
    name                   = "Default-Route-To-NVA"
    address_prefix         = "0.0.0.0/0"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = "10.255.2.4"
  }
}

# ----- Route tables (Central) -----
resource "azurerm_route_table" "cprap" {
  name                = "CPRAP-UDR05"
  resource_group_name = "AzureCore-Cent"
  location            = "canadacentral"
  route {
    name                   = "Default-Route-To-NVA"
    address_prefix         = "0.0.0.0/0"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = "10.254.2.4"
  }
}
resource "azurerm_route_table" "csrap" {
  name                = "CSRAP-UDR05"
  resource_group_name = "AzureCore-Cent"
  location            = "canadacentral"
  route {
    name                   = "Default-Route-To-NVA"
    address_prefix         = "0.0.0.0/0"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = "10.254.2.4"
  }
}

# ----- NSGs (East: SecurityResources-EP/ES) -----
resource "azurerm_network_security_group" "eprap" {
  name                = "EPRAP-NSG05"
  resource_group_name = "SecurityResources-EP"
  location            = "canadaeast"
}
resource "azurerm_network_security_group" "esrap" {
  name                = "ESRAP-NSG05"
  resource_group_name = "SecurityResources-ES"
  location            = "canadaeast"
}

# ----- NSGs (Central) -----
resource "azurerm_network_security_group" "cprap" {
  name                = "CPRAP-NSG05"
  resource_group_name = "SecurityResources-CP"
  location            = "canadacentral"
}
resource "azurerm_network_security_group" "csrap" {
  name                = "CSRAP-NSG05"
  resource_group_name = "SecurityResources-CS"
  location            = "canadacentral"
}

# ----- Subnets East -----
# Subnet depends on VNet. Associations depend on Subnet + Route table / NSG (see DEPENDENCIES.md).
resource "azurerm_subnet" "eprap" {
  name                 = "EPRAP-SUBNET05"
  resource_group_name  = "AzureCore-East"
  virtual_network_name = azurerm_virtual_network.east.name
  address_prefixes     = ["10.255.13.128/26"]
  depends_on           = [azurerm_virtual_network.east]
}
resource "azurerm_subnet" "esrap" {
  name                 = "ESRAP-SUBNET05"
  resource_group_name  = "AzureCore-East"
  virtual_network_name = azurerm_virtual_network.east.name
  address_prefixes     = ["10.255.12.128/26"]
  depends_on           = [azurerm_virtual_network.east]
}
resource "azurerm_subnet_route_table_association" "eprap" {
  subnet_id      = azurerm_subnet.eprap.id
  route_table_id = azurerm_route_table.eprap.id
  depends_on     = [azurerm_subnet.eprap, azurerm_route_table.eprap]
}
resource "azurerm_subnet_route_table_association" "esrap" {
  subnet_id      = azurerm_subnet.esrap.id
  route_table_id = azurerm_route_table.esrap.id
  depends_on     = [azurerm_subnet.esrap, azurerm_route_table.esrap]
}
resource "azurerm_subnet_network_security_group_association" "eprap" {
  subnet_id                 = azurerm_subnet.eprap.id
  network_security_group_id = azurerm_network_security_group.eprap.id
  depends_on                = [azurerm_subnet.eprap, azurerm_network_security_group.eprap]
}
resource "azurerm_subnet_network_security_group_association" "esrap" {
  subnet_id                 = azurerm_subnet.esrap.id
  network_security_group_id = azurerm_network_security_group.esrap.id
  depends_on                = [azurerm_subnet.esrap, azurerm_network_security_group.esrap]
}

# ----- Subnets Central -----
resource "azurerm_subnet" "cprap" {
  name                 = "CPRAP-SUBNET05"
  resource_group_name  = "AzureCore-Cent"
  virtual_network_name = azurerm_virtual_network.central.name
  address_prefixes     = ["10.254.13.128/26"]
  depends_on           = [azurerm_virtual_network.central]
}
resource "azurerm_subnet" "csrap" {
  name                 = "CSRAP-SUBNET05"
  resource_group_name  = "AzureCore-Cent"
  virtual_network_name = azurerm_virtual_network.central.name
  address_prefixes     = ["10.254.12.128/26"]
  depends_on           = [azurerm_virtual_network.central]
}
resource "azurerm_subnet_route_table_association" "cprap" {
  subnet_id      = azurerm_subnet.cprap.id
  route_table_id = azurerm_route_table.cprap.id
  depends_on     = [azurerm_subnet.cprap, azurerm_route_table.cprap]
}
resource "azurerm_subnet_route_table_association" "csrap" {
  subnet_id      = azurerm_subnet.csrap.id
  route_table_id = azurerm_route_table.csrap.id
  depends_on     = [azurerm_subnet.csrap, azurerm_route_table.csrap]
}
resource "azurerm_subnet_network_security_group_association" "cprap" {
  subnet_id                 = azurerm_subnet.cprap.id
  network_security_group_id = azurerm_network_security_group.cprap.id
  depends_on                = [azurerm_subnet.cprap, azurerm_network_security_group.cprap]
}
resource "azurerm_subnet_network_security_group_association" "csrap" {
  subnet_id                 = azurerm_subnet.csrap.id
  network_security_group_id = azurerm_network_security_group.csrap.id
  depends_on                = [azurerm_subnet.csrap, azurerm_network_security_group.csrap]
}
