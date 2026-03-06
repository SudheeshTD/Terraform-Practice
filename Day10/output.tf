output "rgname" {
    value = azurerm_resource_group.rg[*].name 
}


output "env" {
    value = var.environment
  
}

output "demo" {
  value = [for count in local.nsg_rules : count.description]
}

output "splat" {
  value = local.nsg_rules[*].allow_http
}