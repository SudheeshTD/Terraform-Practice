resource "azurerm_resource_group" "rg" {
  name     = "day10-rg"
  location = "eastus"
}

# Create Network Security Group
resource "azurerm_network_security_group" "example" {
  name                = var.environment == "dev" ? "dev-nsg" : "stage-nsg"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  # Here's where we need the dynamic block
  dynamic "security_rule" {
    for_each = local.nsg_rules
    content {
      name                       = security_rule.key
      priority                   = security_rule.value.priority
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range         = "*"
      destination_port_range    = security_rule.value.destination_port_range
      source_address_prefix     = "*"
      destination_address_prefix = "*"
      description               = security_rule.value.description
    }
  }
}

# # Output the security rules
# output "security_rules" {
#   value = azurerm_network_security_group.example.security_rule
# }  

# output "env" {
#   value = var.environment
# }


# output "demo" {
#   value = [ for count in local.nsg_rules : count.description ]
# }

# output "splat" {
#   value = var.account_names[1]
# }