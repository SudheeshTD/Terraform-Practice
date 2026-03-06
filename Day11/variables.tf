variable "subscription_id" {
  description = "The Azure Subscription ID"
  type        = string
}

variable "project-name" {
  type = string
  description = "Name of the Project"
  default = "Project ALPHA Resource"
}

variable "tags"{
  type = map(string)
    default = {
      company    = "TechCorp"
      managed_by = "terraform"
      }
}

variable "environment_tags" {
  type = map(string)
    default = {
       environment  = "production"
       cost_center = "cc-123"
}
}

variable "storage_account_name" {
  type = string
  default = "73yiusfuiarf*^$ubiudffiasunifau*^$sfilauhrfaui0---vkjansfvu"

  
}