locals {
  formatted_name = lower(replace(var.project-name, " ", "-"))
  merge_tags = merge(var.tags, var.environment_tags)
  storage_account_formatted = substr(replace(lower(var.storage_account_name), "/[^a-z0-9]/", ""), 0, 24)
  formatted_ports = split(",", var.allowed_ports)
  nsg_rules = [for port in local.formatted_ports: 
  {
    name = "port-${port}"
    port = port
    description= "Allowed port on port: ${port}"
  }]
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


resource "azurerm_network_security_group" "example" {
  name                = "${local.formatted_name}-nsg"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  # Here's where we need the dynamic block
  dynamic "security_rule" {
    for_each = local.nsg_rules
    content {
      name                       = security_rule.key
      priority                   = 100
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range         = "*"
      destination_port_range    = security_rule.value.port
      source_address_prefix     = "*"
      destination_address_prefix = "*"
      description               = security_rule.value.description
    }
  }
}


output "rg_name" {
    value = azurerm_resource_group.rg.name
  
}
output "Storage_Account_Name" {
    value = azurerm_storage_account.example.name
  
}

output "nsg_rules" {
  value = local.nsg_rules
}

output "security_name" {
  value = azurerm_network_security_group.example
}