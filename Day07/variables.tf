
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
  default = [ "East US", "Central US" ]
}