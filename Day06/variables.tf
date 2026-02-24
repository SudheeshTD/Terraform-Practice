
variable "environment" {
    type = string
    description = "the Env type"
    default = "staging"
 }

variable "subscription_id" {
  description = "The Azure Subscription ID"
  type        = string
}