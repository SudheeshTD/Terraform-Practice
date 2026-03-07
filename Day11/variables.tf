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

variable "allowed_ports" {
  type = string
  default = "80,443,8080,3306"
}

variable "environment" {
  type = string
  description = "Environment Names"
  default = "dev"
  validation {
    condition = contains(["dev", "staging", "prod"], var.environment)
    error_message = "Enter Valid value for Env:"
  }
}

variable "vm_sizes" {
  type = map(string)
  default = {
    "dev" = "standard_D2s_v3"
    "staging" = "standard_D4s_v3"
    "prod" = "standard_D8s_v3"
  }
}

variable "vm_size" {
  type = string
  default = "standard_D2s_v3"
  validation {
    condition = length(var.vm_size) >= 2 && length(var.vm_size) <=20
    error_message = "VM Size should be between 2 and 20"
  }
  validation {
    condition = strcontains(lower(var.vm_size), "standard")
    error_message = "VM size should have a substring of standard in it"
  }
}

variable "backup_name" {
  default = "test-backup"
  type = string
  validation {
    condition = endswith(var.backup_name,"_backup")
    error_message = "The Backup name should end with _backup"
  }
}

variable "credential" {
  default = "xyzkasrhf"
  type = string
  sensitive = true
}

