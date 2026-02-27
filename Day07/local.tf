locals {
  common_tags = {
    environment = var.environment
    lob = "Banking"
    stage = "alpha"
  }
}