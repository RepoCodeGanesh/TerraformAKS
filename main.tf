provider "azurerm" {
  features {}
  subscription_id = "f4ffefe1-d689-4059-969c-ccc73e2a11d4"
  tenant_id       = "4cef0d84-84d6-4ed0-8abe-773b015bcf99"
  client_id       = "0dfa47eb-cb5f-4a19-8edc-192901b73c82"
  client_secret   = var.client_secret
}

resource "azurerm_resource_group" "RG" {
  name     = "AKS1"
  location = "East US"
}

resource "azurerm_kubernetes_cluster" "AKSResource1" {
  name                = "Cluster1"
  location            = azurerm_resource_group.RG.location
  resource_group_name = azurerm_resource_group.RG.name
  dns_prefix          = "dnsaks"

  default_node_pool {
    name       = "agentpool"
    node_count = 1
    vm_size    = "Standard_DS2_v2"
  }

  identity {
    type = "SystemAssigned"
  }
}

output "aks_credentials_command" {
  value = "az aks get-credentials --resource-group ${azurerm_resource_group.RG.name} --name ${azurerm_kubernetes_cluster.AKSResource1.name} --overwrite-existing"
}
