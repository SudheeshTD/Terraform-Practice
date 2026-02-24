# Terraform

`terraform -version` - Version

`az ad sp create-for-rbac -n az-demo --role="Contributor" --scopes="/subscriptions/$SUBSCRIPTION_ID"` - creating a service pronciple

export ARM_CLIENT_ID=""
export ARM_CLIENT_SECRET=""
export ARM_SUBSCRIPTION_ID=""
export ARM_TENANT_ID=""

`alias tf=terraform` - TO set an alias, so i dont have to run it again and again

`terraform init` - Prepare your working directory for other commands. To make the initial dependency selections that will initialize the dependency lock file.

`tf plan` = Show changes required by the current configuration

`tf apply` - Create or update infrastructure

`tf apply --auto-approve` - Create or update infrastructure without approval

`tf apply --auto-approve` - Dest roy previously-created infrastructure

`terraform refresh` - reconciles your local Terraform state file with the actual, current infrastructure in your cloud provider, updating the state to match reality.

Backend.sh file to storage the state file of Terraform in azure which holds deployment details.

## Adding Variable

### Input Variables

1. Locals - in file with variable or as locals
   locals {
   common_tags = {
   environment = "dev"
   lob = "Banking"
   stage = "alpha"
   }
   }

2. `tf plan -var=environment=dev` - Give custom variable as input while running in CLI

3. terraform.tfvars - file in the main folder that can contain variable for the terraform main file.

Precedence: CLI(-var) > tfvars File > Inbuilt

### Output Variables

output "storage-account-name" {
value = azurerm_storage_account.example.name
}

## File Structure

- If you have a env file to load variables: run `source .env` before `tf plan`.

**best way is to create a .tfvars file and store ad keyvalue store and reference as variable and then into where required**
