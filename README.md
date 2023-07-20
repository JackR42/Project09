# Project09
Azure DevOps Pipeline - VM jumpbox with web-based RDP via Bastion

01. Determine project name, eg: Bastion42
02. Create empty GitHub repository with Readme.md, e.g.: GitHub repo Bastion42
03. Add script to repo: AZ-GH-TF-Pre-Reqs.ps1
04. Run prerequisites script: AZ-GH-TF-Pre-Reqs.ps1
- a. Create Core resource group for the project
- b. Create KeyVault for Secrets in Core RG
- c. Create Storage account for stateful Terraform Backend in Core RG
- d. Create SPN - Service Provider for connecting Azure DevOps Pipeline
- e. Validate if all Core resources have been created
05. Create empty Azure Devops project
06. Create New Pipeline and Connect to Github repo
07. Create Service Connection from Azure DevOps Pipeline to Azure backend
08. Create empty Pipeline, using SPN to Azure and service connection to Azure
09. Create Terraform template main.tf with basic commands for creating basic resource from KeyVault parameters
10. Run Pipeline and validate if Project resources have been created
11. Add main.tf containing Terraform commands
 	a. Change Core Resource Group name 
	b. Change KeyVault name


**References:**
- https://github.com/guillermo-musumeci/terraform-azure-vm-windows-bastion-v2
- https://www.ntweekly.com/2022/06/23/create-azure-vnet-subnet-and-nsg-with-terraform/
- https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/bastion_host
- https://dev.to/holger/test-azure-bastion-deployment-via-terraform-18o8

- Availability Groups with SQLDB (not SQLVM, SQLMI): https://medium.com/devops-dudes/create-azure-sql-failover-group-using-terraform-16702749bb50
- Run Powershell: https://techcommunity.microsoft.com/t5/itops-talk-blog/how-to-run-powershell-scripts-on-azure-vms-with-terraform/ba-p/3827573