# Variables.tf - Generic variables

variable "sub-name" {
    description = "The prefix defined for the Subscription"
    default = "S0"
}
variable "env-name" {
    description = "The name of the environment"
    default = "ENV"
}
variable "app-name" {
    description = "The name of the application"
    default = "Project51"
}
variable "loc-name" {
  description = "The name of the Azure Region in which all resources should be created."
  default = "westeurope"
}
variable "vm0-name" {
  description = "The name of the VM Jumpbox."
  default = "VM0"
}

variable "vm1-name" {
  description = "The name of the first VM SQL."
  default = "VMSQL1"
}
variable "vm2-name" {
  description = "The name of the second VM SQL."
  default = "VMSQL2"
}

variable "sqldb1-name" {
  description = "The name of the first SQLDB virtual instance."
  default = "SQLDB1"
}

variable "sqldb2-name" {
  description = "The name of the second SQLDB virtual instance."
  default = "SQLDB2"
}

variable "project" {
  description = "Input parameter $Project for powershell script VM-Configure.ps1"
  type        = string
  default     = "Project51"
}
