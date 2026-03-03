output "rgname" {
    value = azurerm_resource_group.example[*].name 
}

output "storage_name" {
  value = [for i in azurerm_storage_account.example: i.name]
}