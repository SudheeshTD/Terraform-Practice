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

`tf apply --auto-approve` - Destroy previously-created infrastructure

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

- Implecit Dependency - Dependency created by the file itself.
- Explicit dependency - Dependency mentioned in file. (Avoid this generally)

- to address the defined tuple as variable in other file

## Meta Arguments:

- `count` - to create multiple resources with same configuration
- `for_each` - to create multiple resources with same configuration but different values. Cannot be used on list as it can contain duplicate values, it can only be used on set or map.
- `depends_on` - to create dependency between resources(Explicit Dependency)
- `lifecycle` - to manage the lifecycle of resources (create before destroy, prevent destroy, ignore changes, replace triggers custom conditions)
- `provider` - to specify the provider for the resource
- `provisioner` - to execute scripts or commands on the resource after creation
- `connection` - to specify the connection details for the provisioner

## Methods:

- `contains` - to check if a list contains a specific value
- `length` - to get the length of a list or map

## Dynamic Block:

- to create multiple blocks of the same type with different values. It is used to create multiple blocks of the same type with different values. It is used to create multiple blocks of the same type with different values.
  `dynamic "network_interface" {`
  `for_each = var.network_interfaces`
  `content {`
  `name = network_interface.value.name`
  `}`
  `}`

**Splat Expression:**

- to access the attributes of a resource that is created with count or for_each. It is used to access the attributes of a resource that is created with count or for_each. It is used to access the attributes of a resource that is created with count or for_each.
  azurerm_network_interface.example[*].id

## Data Source:

- to get the details of an existing resource in the cloud provider.

  `data "azurerm_resource_group" "example" {`
  `name = "example-resources"(name of the Existing resource group to get details of from cloud provider)`
  `}`

## How Azure WOrks:

Most Outer Layer - **Management Group**
Next Layer - **Subscription**
Next Layer - **Resource Group**
Next Layer - **Virtual Network(Vnet)** - It has a CIDR block associated with it which is a range of IP addresses that can be used for the resources in the Vnet.
Everythn=ing is inside the Vnet.
**Public IP** - It is used to access the resources in the Vnet from the internet. It is associated with a network interface.
**Network Gateway/Load Balancer** **- It is used to connect the Vnet to the on-premises network or to the internet. It is associated with a public IP and a network interface.
**Subnets** - It is a range of IP addresses that can be used for the resources in the Vnet. It is associated with a network interface.
Subnets will have **Network Security Group(NSG)** associated with it which is used to control the inbound and outbound traffic to the resources in the subnet. NSG will have rules associated with it which will allow or deny the traffic based on the source, destination, port and protocol.
**VMSS\*\* - It is a group of virtual machines that are created from the same image and have the same configuration. It is used to create a scalable and highly available application. Its Inside Subnet. it can have scale rule to autoscale.

- its also called backend pool of load balancer as it is associated with the load balancer and the load balancer will distribute the traffic to the virtual machines in the VMSS.
  **VM** - will be inside the VMSS that process the request.4

**NAT** - It is used to translate the private IP addresses of the resources in the Vnet to the public IP address of the load balancer. It is associated with a network interface and a public IP. so that the resources in the Vnet can access the internet and the users can access the resources in the Vnet from the internet.

How Request Flows:

1. User sends a request to the public IP of the load balancer.
2. The load balancer receives the request and distributes it to one of the virtual machines in the VMSS based on the load balancing algorithm.
3. Load Balancer will have a health probe associated with it which will check the health of the virtual machines in the VMSS and if any virtual machine is unhealthy, it will stop sending traffic to that virtual machine until it becomes healthy again. ports 80 and 443 are generally used for web applications.
4. The virtual machine processes the request and sends the response back to the load balancer.
5. The load balancer receives the response from the virtual machine and sends it back to the user.
