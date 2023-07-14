# variables-dev.tfvars

# Generic variables
sub-name = "S1"
env-name = "DEV"
app-name = "Project09"
loc-name = "westeurope"
#vnet-cidr   = "10.10.0.0/16"
#bastion-subnet-cidr = "10.10.1.0/24"
vnet-cidr   = "10.40.2.0/24"
subnet-cidr-bastion = "10.40.2.0/25"
subnet-cidr-vms  = "10.40.2.128/25"
