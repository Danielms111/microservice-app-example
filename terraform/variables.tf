variable "subscription_id" {
    description = "ID de la suscripción de Azure"
    type        = string
}

variable "resource_group_name" {
    type    = string
    default = "devops-rg"
}

variable "location" {
    type    = string
    default = "East US"
}

variable "virtual_network_name" {
    default = "devops-vnet"
}

variable "virtual_network_address_space" {
    default = "10.0.0.0/16"
}

variable "subnet_name" {
    default = "devops-subnet"
}

variable "subnet_address_prefix" {
    default = "10.0.1.0/24"
}

variable "public_ip_name" {
    default = "devops-ip"
}

variable "network_interface_name" {
    default = "devops-nic"
}

variable "nsg_name" {
    default = "devops-nsg"
}

variable "vm_name" {
    default = "devops-vm"
}

variable "vm_size" {
    default = "Standard_DS1_v2"
}

variable "admin_username" {
    default = "adminuser"
}

variable "admin_password" {
    default = "Password*#1234"
}

variable "os_disk_storage_type" {
    default = "Standard_LRS"
}

variable "image_publisher" {
    default = "Canonical"
}

variable "image_offer" {
    default = "0001-com-ubuntu-server-jammy"
}

variable "image_sku" {
    default = "22_04-lts"
}

variable "image_version" {
    default = "latest"
}
