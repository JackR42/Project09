# Starter pipeline

# Start with a minimal pipeline that you can customize to build and deploy your code.
# Add steps that build, run tests, deploy, and more:
# https://aka.ms/yaml

trigger:
- main

pool:
  vmImage: ubuntu-latest

stages:
- stage: TF_DEPLOY
  jobs:
  - job:
    steps:
    - task: TerraformInstaller@1
      inputs:
        terraformVersion: 'latest'
    - task: TerraformTaskV4@4
      inputs:
        provider: 'azurerm'
        command: 'init'
        backendServiceArm: 'SPN-Bastion42'
        backendAzureRmResourceGroupName: 'S2-RG-CORE'
        backendAzureRmStorageAccountName: 'storagecrbastion42281857'
        backendAzureRmContainerName: 'tfstate'
        backendAzureRmKey: 'main.tf'
    - task: TerraformTaskV4@4
      inputs:
        provider: 'azurerm'
        command: 'plan'
        commandOptions: '-out=main.tfplan -input=false'
        environmentServiceNameAzureRM: 'SPN-Bastion42'

    - task: TerraformTaskV4@4
      inputs:
        provider: 'azurerm'
        command: 'apply'
        environmentServiceNameAzureRM: 'SPN-Bastion42'

- stage: TF_DECOMMISSION
  jobs:
  - job: ApproveDecom
    pool: server
    steps:
    - task: ManualValidation@0
      displayName: TF Approve
      inputs:
        instructions: 'Stage TF_DECOMMISSION, do you approve?'

  - job:
    dependsOn: ApproveDecom
    condition: Succeeded()
    steps:
    - task: TerraformInstaller@0
      displayName: 'TF Install'
      inputs:
        terraformVersion: 'latest'
    - task: TerraformTaskV4@4
      inputs:
        provider: 'azurerm'
        command: 'init'
        backendServiceArm: 'SPN-Bastion42'
        backendAzureRmResourceGroupName: 'S2-RG-CORE'
        backendAzureRmStorageAccountName: 'storagecrbastion42281857'
        backendAzureRmContainerName: 'tfstate'
        backendAzureRmKey: 'main.tf'
    - task: TerraformTaskV4@4
      inputs:
        provider: 'azurerm'
        command: 'destroy'
        environmentServiceNameAzureRM: 'SPN-Bastion42'
