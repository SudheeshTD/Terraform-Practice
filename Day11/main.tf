locals {
  formatted_name = lower(replace(var.project-name, " ", "-"))
  merge_tags = merge(var.tags, var.environment_tags)
  storage_account_formatted = substr(replace(lower(var.storage_account_name), "/[^a-z0-9]/", ""), 0, 24)
}

resource "azurerm_resource_group" "rg" {
  name = "${local.formatted_name}-rg"
  location = "eastus"

  tags = local.merge_tags

}


resource "azurerm_storage_account" "example" {

  name                     = local.storage_account_formatted
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "GRS"

}

output "rg_name" {
    value = azurerm_resource_group.rg.name
  
}
output "Storage_Account_Name" {
    value = azurerm_storage_account.example.name
  
}