# Variables.tf - Generic variables

variable "env" {
    description = "The name of the environment"
    default = "env-default"
}
variable "resource-group-name" {
    description = "The name of the resource group"
    default = "rg-default"
}
variable "location-name" {
  description = "The name of the Azure Region in which all resources should be created."
  default = "westeurope"
}
