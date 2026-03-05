# Load balancer (LB) – Kiteworks

**No Load Balancer was found or added** for Kiteworks in this Terraform config.

- **Kiteworks RGs** (Kiteworks-EP, Kiteworks-ES, Kiteworks-CP, Kiteworks-CS): no LB resources were defined.
- **Shared RGs** (AzureCore-East, AzureCore-Cent): HMIP uses EPRMG-LB01 in AzureCore-East on subnet EPRMG; Kiteworks uses EPRAP/ESRAP and CPRAP/CSRAP subnets, so that LB is not used by Kiteworks.

## If you find an LB for Kiteworks

1. List LBs in the subscription or in a Kiteworks RG:
   ```bash
   az network lb list -o table
   az network lb list -g Kiteworks-EP -o table
   ```
2. Inspect a specific LB (name, frontend, backend pool, rules):
   ```bash
   az network lb show -g <resource-group> -n <lb-name> -o json
   az network lb address-pool list -g <rg> --lb-name <lb-name> -o table
   az network lb rule list -g <rg> --lb-name <lb-name> -o table
   ```
3. Add Terraform in `resources-network.tf` following the HMIP pattern in `az/hmip - Copy/hmip-merged/resources-network.tf`:
   - `azurerm_lb`
   - `azurerm_lb_backend_address_pool`
   - `azurerm_lb_rule` (and optionally `azurerm_lb_probe` if health probes exist)
4. If the LB is in a shared RG (e.g. AzureCore-East), use the same RG name and the subnet where the LB frontend lives (you may need to add that subnet if it’s not EPRAP/ESRAP/CPRAP/CSRAP).

See **DEPENDENCIES.md** section “5. Load balancer” for the dependency order when adding an LB.
