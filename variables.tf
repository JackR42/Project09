# Variables.tf - Generic variables

variable "sub-name" {
    description = "The prefix defined for the Subscription"
    default = "S2"
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

