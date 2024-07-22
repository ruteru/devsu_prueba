provider "azurerm" {
  features {}
}

provider "kubernetes" {
  config_path = "~/.kube/config"
}

resource "azurerm_resource_group" "main" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_kubernetes_cluster" "aks" {
  name                = var.aks_cluster_name
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  dns_prefix          = var.aks_cluster_name

  default_node_pool {
    name       = "default"
    node_count = 2
    vm_size    = "Standard_DS2_v2"
  }

  identity {
    type = "SystemAssigned"
  }
}

resource "azurerm_container_registry" "acr" {
  name                = var.acr_name
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  sku                 = "Standard"
  admin_enabled       = true
}

resource "azurerm_role_assignment" "acr_pull" {
  scope                = azurerm_container_registry.acr.id
  role_definition_name = "AcrPull"
  principal_id         = azurerm_kubernetes_cluster.aks.kubelet_identity[0].object_id
}

resource "kubernetes_secret" "acr_secret" {
  metadata {
    name      = "acr-secret"
    namespace = "default"
  }

  data = {
    ".dockerconfigjson" = base64encode(jsonencode({
      auths = {
        "${azurerm_container_registry.acr.login_server}" = {
          username = var.acr_username
          password = var.acr_password
        }
      }
    }))
  }

  type = "kubernetes.io/dockerconfigjson"
}

variable "resource_group_name" {
  type        = string
  default     = "devsu-demo-rg"
}

variable "location" {
  type        = string
  default     = "westus"
}

variable "aks_cluster_name" {
  type        = string
  default     = "devsu-demo-aks"
}

variable "acr_name" {
  type        = string
  default     = "devsudemoregistry"
}

variable "acr_username" {
  type        = string
}

variable "acr_password" {
  type        = string
  sensitive   = true
}

output "kubernetes_cluster_name" {
  value = azurerm_kubernetes_cluster.aks.name
}

output "acr_login_server" {
  value = azurerm_container_registry.acr.login_server
}
