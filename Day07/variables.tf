
variable "environment" {
    type = string
    description = "the Env type"
    default = "staging"
 }

variable "subscription_id" {
  description = "The Azure Subscription ID"
  type        = string
}


variable "storage_disk" {
    type = number
    description = "Value for the Disk storage of OS"
    default = 80
  
}

variable "is_delete" {
  type = bool
  description = "Default behaviour to OS disk upon VM terminaton"
  default = true
}

variable "allowed_locations" {
  type = list(string)
  description = "value"
  default = [ "eastus","centralus" ]
}

variable "resource_tags" {
  type = map(string)
  description = "tags to apply to the resources"
  default = {
    "environment" = "staging"
    "managed_by" = "terraform"
    "department" = "devops"
  }
}


variable "network_config" {
  type = tuple([ string, string, number ])
  description = "Network Configuration(VNET address, subnet address, subnet mask )"
  default = [ "10.0.0.0/16", "10.0.2.0", 24 ]
}

variable "allowed_vm_size" {
  type = list(string)
  description = "Alljowed VM sizes"
  default = [ "Standard_D2s_v3" ]
}

variable "vm_config" {
  type = object({
    size      = string
    publisher = string
    offer     = string
    sku       = string
    version   = string
  })

  description = "Virtual machine configuration"

  default = {
    size      = "Standard_DS1_v2"
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
  
}