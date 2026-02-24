terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "~>4.8.0  "
    }
  }
  required_version = ">=1.9.0"
    
  backend "azurerm" {
    resource_group_name = "tfstate-day04"  #
    storage_account_name = "day049870"                                 # Can be passed via `-backend-config=`"storage_account_name=<storage account name>"` in the `init` command.
    container_name       = "tfstate"                                  # Can be passed via `-backend-config=`"container_name=<container name>"` in the `init` command.
    key                  = "demo.terraform.tfstate"                   # Can be passed via `-backend-config=`"key=<blob key name>"` in the `init` command.
  }

}

provider "azurerm" {
  features {
    
  }
}

variable "environment" {
    type = string
    description = "the Env type"
    default = "staging"
 }

locals {
  common_tags = {
    environment = "dev"
    lob = "Banking"
    stage = "alpha"
  }
}



resource "azurerm_resource_group" "example" {
  name     = "example-resources"
  location = "West Europe"
}

resource "azurerm_storage_account" "example" {
  name                     = "terra101az"
  resource_group_name      = azurerm_resource_group.example.name
  location                 = azurerm_resource_group.example.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = {
    environment = local.common_tags.stage
  }
}

output "storage-account-name" {
  value = azurerm_storage_account.example.name
}