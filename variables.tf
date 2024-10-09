variable "location" {
    type = string
    description = "project location"
}

variable "env" {
    type = string
    description = "environment name"
}

variable "project" {
    type = string
    description = "project name"
}

variable "vnet_cidr" {
    type = list(string)
    description = "vnet cidr"
}

variable "sub1_cidr" {
    type = list(string)
    description = "subnet01 cidr"
}

variable "sub2_cidr" {
    type = list(string)
    description = "subnet02 cidr"
}

variable "tier" {
    type = string
    description = "Storage account tier"
}

variable "replica_type" {
    type = string
    description = "Storage Replication type"
}

variable "blob1_name" {
    type = string
    description = "blob Name"
}

variable "ip_rules" {
    type = list(string)
    description = "IPs whiteist"
}

#####################Linux Vitual machine#######################

variable "vm01_username" {
    type = string
    description = "virtual machine name"
    sensitive   = true
}

variable "vm01_userpswd" {
    type = string
    description = "virtual machine password"
    sensitive   = true
}


variable "vm01_size" {
    type = string
    description = "Virtual Machine size"
}

variable "vm01_publisher" {
    type = string
    description = "Virtual machine publisher"
}

variable "vm01_offer" {
    type = string
    description = "virtual machine os offer"
}

variable "vm01_sku" {
    type = string
    description = "Virtual machine SKU"
}
#######################Windows Virtual Macchine ######################

variable "vm02_username" {
    type = string
    description = "virtual machine name"
    sensitive   = true
}

variable "vm02_userpswd" {
    type = string
    description = "virtual machine password"
    sensitive   = true
}

variable "vm02_size" {
    type = string
    description = "Virtual Machine size"
}

variable "vm02_publisher" {
    type = string
    description = "Virtual machine publisher"
}

variable "vm02_offer" {
    type = string
    description = "virtual machine os offer"
}

variable "vm02_sku" {
    type = string
    description = "Virtual machine SKU"
}