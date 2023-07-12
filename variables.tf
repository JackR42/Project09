# Variables.tf - Generic variables

variable "env-name" {
    description = "The name of the environment"
    default = "DEV"
}
variable "rg-name" {
    description = "The name of the resource group"
    default = "rg-default"
}
variable "loc-name" {
  description = "The name of the Azure Region in which all resources should be created."
  default = "westeurope"
}
