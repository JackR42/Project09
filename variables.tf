# Variables.tf - Generic variables

variable "sub-name" {
    description = "The prefix defined for the Subscription"
    default = "DEV"
}
variable "env-name" {
    description = "The name of the environment"
    default = "DEV"
}
variable "app-name" {
    description = "The name of the application"
    default = "Project51"
}
variable "loc-name" {
  description = "The name of the Azure Region in which all resources should be created."
  default = "westeurope"
}

variable "rg-name" {
    description = "The name of the resource group"
    default = "${var.sub-name}-RG-${var.app-name}-${var.env-name}"
}

