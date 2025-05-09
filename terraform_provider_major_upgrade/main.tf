terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
}

provider "azurerm" {
  features {
    
  }
}

resource "azurerm_resource_group" "example" {
  name     = "example-resources"
  location = "West Europe"
}

resource "azurerm_virtual_network" "example" {
  name                = "example-vnet"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
}

# You'll see very weird expressions assigned to `private_endpoint_network_policies` and `private_link_service_network_policies_enabled`, the logic comes from https://github.com/hashicorp/terraform-provider-azurerm/blob/v3.117.0/internal/services/network/subnet_resource.go#L361-L410
resource "azurerm_subnet" "example" {
  name                                      = "example-subnet"
  resource_group_name                       = azurerm_resource_group.example.name
  virtual_network_name                      = azurerm_virtual_network.example.name
  address_prefixes                          = ["10.0.1.0/24"]
  private_endpoint_network_policies_enabled = false

  delegation {
    name = "delegation"

    service_delegation {
      name    = "Microsoft.ContainerInstance/containerGroups"
      actions = ["Microsoft.Network/virtualNetworks/subnets/join/action", "Microsoft.Network/virtualNetworks/subnets/prepareNetworkPolicies/action"]
    }
  }
}

