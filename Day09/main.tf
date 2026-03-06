
resource "azurerm_resource_group" "example" {

  lifecycle {
    create_before_destroy = true
    #prevent_destroy = true
    precondition {
      condition = contains(var.allowed_locations, var.location)
      error_message = "Please Enter a valid location"
    }
  }

  name     = "${var.environment}-resources"
  location = var.location

  tags = {
    environment = var.environment
  }

}

resource "azurerm_storage_account" "example" {
# count = len(var.storage_account_name)
# name = var.storage_account_name(count.index)

  for_each = var.storage_account_name
  name                     = each.value
  resource_group_name      = azurerm_resource_group.example.name
  location                 = azurerm_resource_group.example.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  
  lifecycle {
    create_before_destroy = true
    replace_triggered_by = [ azurerm_resource_group.example.id ]
    ignore_changes = [ account_replication_type ]
  }


  tags = {
    environment = var.environment
  }
}