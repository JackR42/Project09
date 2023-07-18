variable "vnet-cidr" {
  type        = string
  description = "The CIDR of the VNET Virtual Network"
}
variable "subnet-cidr" {
  type        = string
  description = "The CIDR of the SUBNET to be assigned to the VNET for VMs"
}
