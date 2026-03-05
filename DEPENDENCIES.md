# Kiteworks Terraform – Dependency graph (whole picture)

For each resource type **linked to a VM**, this document lists its **own dependencies** so you see the full chain. Order is from root (no deps) to leaf (VM).

---

## 1. Subscription

| Resource | Terraform address | Depends on |
|----------|-------------------|------------|
| Subscription | `data.azurerm_subscription.current` | — (data source, no dependencies) |

---

## 2. Resource groups

| Resource | Terraform address | Depends on |
|----------|-------------------|------------|
| Kiteworks-CP | `azurerm_resource_group.cp` | — |
| Kiteworks-CS | `azurerm_resource_group.cs` | — |
| Kiteworks-EP | `azurerm_resource_group.ep` | — |
| Kiteworks-ES | `azurerm_resource_group.es` | — |

*Note: AzureCore-East, AzureCore-Cent, SecurityResources-* are not defined in this repo; they are used as literal `resource_group_name`.*

---

## 3. Virtual network

| Resource | Terraform address | Depends on |
|----------|-------------------|------------|
| East VNet (eastcmhc-vnet01) | `azurerm_virtual_network.east` | — (uses literal `resource_group_name = "AzureCore-East"`) |
| Central VNet (centcmhc-vnet01) | `azurerm_virtual_network.central` | — (uses literal `resource_group_name = "AzureCore-Cent"`) |

---

## 4. Route table

| Resource | Terraform address | Depends on |
|----------|-------------------|------------|
| EPRAP-UDR05 | `azurerm_route_table.eprap` | — (AzureCore-East) |
| ESRAP-UDR05 | `azurerm_route_table.esrap` | — (AzureCore-East) |
| CPRAP-UDR05 | `azurerm_route_table.cprap` | — (AzureCore-Cent) |
| CSRAP-UDR05 | `azurerm_route_table.csrap` | — (AzureCore-Cent) |

---

## 5. Network security group

| Resource | Terraform address | Depends on |
|----------|-------------------|------------|
| EPRAP-NSG05 | `azurerm_network_security_group.eprap` | — (SecurityResources-EP) |
| ESRAP-NSG05 | `azurerm_network_security_group.esrap` | — (SecurityResources-ES) |
| CPRAP-NSG05 | `azurerm_network_security_group.cprap` | — (SecurityResources-CP) |
| CSRAP-NSG05 | `azurerm_network_security_group.csrap` | — (SecurityResources-CS) |

---

## 6. Subnet

| Resource | Terraform address | Depends on |
|----------|-------------------|------------|
| EPRAP-SUBNET05 | `azurerm_subnet.eprap` | `azurerm_virtual_network.east` |
| ESRAP-SUBNET05 | `azurerm_subnet.esrap` | `azurerm_virtual_network.east` |
| CPRAP-SUBNET05 | `azurerm_subnet.cprap` | `azurerm_virtual_network.central` |
| CSRAP-SUBNET05 | `azurerm_subnet.csrap` | `azurerm_virtual_network.central` |

---

## 7. Subnet – route table association

| Resource | Terraform address | Depends on |
|----------|-------------------|------------|
| EPRAP subnet ↔ route | `azurerm_subnet_route_table_association.eprap` | `azurerm_subnet.eprap`, `azurerm_route_table.eprap` |
| ESRAP subnet ↔ route | `azurerm_subnet_route_table_association.esrap` | `azurerm_subnet.esrap`, `azurerm_route_table.esrap` |
| CPRAP subnet ↔ route | `azurerm_subnet_route_table_association.cprap` | `azurerm_subnet.cprap`, `azurerm_route_table.cprap` |
| CSRAP subnet ↔ route | `azurerm_subnet_route_table_association.csrap` | `azurerm_subnet.csrap`, `azurerm_route_table.csrap` |

---

## 8. Subnet – NSG association

| Resource | Terraform address | Depends on |
|----------|-------------------|------------|
| EPRAP subnet ↔ NSG | `azurerm_subnet_network_security_group_association.eprap` | `azurerm_subnet.eprap`, `azurerm_network_security_group.eprap` |
| ESRAP subnet ↔ NSG | `azurerm_subnet_network_security_group_association.esrap` | `azurerm_subnet.esrap`, `azurerm_network_security_group.esrap` |
| CPRAP subnet ↔ NSG | `azurerm_subnet_network_security_group_association.cprap` | `azurerm_subnet.cprap`, `azurerm_network_security_group.cprap` |
| CSRAP subnet ↔ NSG | `azurerm_subnet_network_security_group_association.csrap` | `azurerm_subnet.csrap`, `azurerm_network_security_group.csrap` |

---

## 9. Network interface (linked to VM)

| Resource | Terraform address | Depends on |
|----------|-------------------|------------|
| ep_nic01 (eppd1vmkwmft01791) | `azurerm_network_interface.ep_nic01` | `azurerm_resource_group.ep`, `azurerm_subnet.eprap` |
| ep_nic02 (eppd1vmkwmft02991) | `azurerm_network_interface.ep_nic02` | `azurerm_resource_group.ep`, `azurerm_subnet.eprap` |
| ep_nic03 (eppd1vm1kwmft1868) | `azurerm_network_interface.ep_nic03` | `azurerm_resource_group.ep`, `azurerm_subnet.eprap` |
| es_nic01 (esut1vmkwmft02737) | `azurerm_network_interface.es_nic01` | `azurerm_resource_group.es`, `azurerm_subnet.esrap` |
| es_nic02 (esut1kwmft01971) | `azurerm_network_interface.es_nic02` | `azurerm_resource_group.es`, `azurerm_subnet.esrap` |
| es_nic03 (eppd1kwmft01834) | `azurerm_network_interface.es_nic03` | `azurerm_resource_group.es`, `azurerm_subnet.esrap` |
| cp_nic01 (cppd1vmkwmft02829) | `azurerm_network_interface.cp_nic01` | `azurerm_resource_group.cp`, `azurerm_subnet.cprap` |
| cs_nic01 (csut1kwmft0192) | `azurerm_network_interface.cs_nic01` | `azurerm_resource_group.cs`, `azurerm_subnet.csrap` |
| cs_nic02 (cppd1kwmft01595) | `azurerm_network_interface.cs_nic02` | `azurerm_resource_group.cs`, `azurerm_subnet.csrap` |

---

## 10. Managed disk (linked to VM)

| Resource | Terraform address | Depends on |
|----------|-------------------|------------|
| ep_vm01 OS | `azurerm_managed_disk.ep_vm01_os` | `azurerm_resource_group.ep` |
| ep_vm01 data1 | `azurerm_managed_disk.ep_vm01_data1` | `azurerm_resource_group.ep` |
| ep_vm01 data2 | `azurerm_managed_disk.ep_vm01_data2` | `azurerm_resource_group.ep` |
| ep_vm02 OS | `azurerm_managed_disk.ep_vm02_os` | `azurerm_resource_group.ep` |
| ep_vm02 data1 | `azurerm_managed_disk.ep_vm02_data1` | `azurerm_resource_group.ep` |

*(Add rows for ES/CP/CS disks when defined.)*

---

## 11. Virtual machine (top of chain)

| Resource | Terraform address | Depends on |
|----------|-------------------|------------|
| EPPD1VMKWMFT01 | `azurerm_virtual_machine.ep_vm01` | `azurerm_resource_group.ep`, `azurerm_network_interface.ep_nic01`, `azurerm_managed_disk.ep_vm01_os`, `azurerm_managed_disk.ep_vm01_data1`, `azurerm_managed_disk.ep_vm01_data2` |
| EPPD1VMKWMFT02 | `azurerm_virtual_machine.ep_vm02` | `azurerm_resource_group.ep`, `azurerm_network_interface.ep_nic02`, `azurerm_managed_disk.ep_vm02_os`, `azurerm_managed_disk.ep_vm02_data1` |

*(Add rows for remaining VMs when defined.)*

---

## Full chain: VM → all linked resources and their dependencies

For **one VM** (e.g. EPPD1VMKWMFT01), the full picture is:

```
VM (ep_vm01)
├── depends on: RG (ep)
├── depends on: NIC (ep_nic01)
│   ├── depends on: RG (ep)
│   └── depends on: Subnet (eprap)
│       ├── depends on: VNet (east)
│       ├── linked by association: Route table (eprap)
│       └── linked by association: NSG (eprap)
├── depends on: OS disk (ep_vm01_os)
│   └── depends on: RG (ep)
└── depends on: Data disks (ep_vm01_data1, ep_vm01_data2)
    └── each depends on: RG (ep)
```

So for each resource linked to the VM, **its own dependencies** are:

| Resource linked to VM | Its own dependencies |
|------------------------|------------------------|
| **Resource group** | — |
| **NIC** | Resource group, **Subnet** |
| **Subnet** | **VNet** |
| **Subnet (route)** | (Subnet + Route table via association) |
| **Subnet (NSG)** | (Subnet + NSG via association) |
| **Route table** | — (RG is literal) |
| **NSG** | — (RG is literal) |
| **VNet** | — (RG is literal) |
| **OS disk** | Resource group |
| **Data disk** | Resource group |
| **VM** | Resource group, NIC(s), OS disk, Data disk(s) |

---

## Dependency order for apply/destroy

**Apply (create):**  
Subscription (data) → RGs → VNet, Route tables, NSGs → Subnets → Subnet associations → NICs → Disks → VMs.

**Destroy:**  
VMs → Disks, NICs → Subnet associations → Subnets → Route tables, NSGs, VNet → RGs.

Terraform infers this from references; you can add explicit `depends_on` in the VM resource if you want the graph documented in code.
