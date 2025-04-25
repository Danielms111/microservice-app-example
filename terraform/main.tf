provider "azurerm" {
    features {}
}

resource "azurerm_resource_group" "rg" {
    name     = var.resource_group_name
    location = var.location
}

resource "azurerm_virtual_network" "vnet" {
    name                = var.virtual_network_name
    address_space       = [var.virtual_network_address_space]
    location            = var.location
    resource_group_name = var.resource_group_name

    depends_on = [azurerm_resource_group.rg]

}

resource "azurerm_subnet" "subnet" {
    name                 = var.subnet_name
    resource_group_name  = var.resource_group_name
    virtual_network_name = var.virtual_network_name
    address_prefixes     = [var.subnet_address_prefix]

    depends_on = [azurerm_virtual_network.vnet]

}

resource "azurerm_public_ip" "public_ip" {
    name                = var.public_ip_name
    location            = var.location
    resource_group_name = var.resource_group_name
    allocation_method   = "Static"

    depends_on = [azurerm_resource_group.rg]

}

resource "azurerm_network_interface" "nic" {
    name                = var.network_interface_name
    location            = var.location
    resource_group_name = var.resource_group_name

    ip_configuration {
        name                          = "internal"
        subnet_id                     = azurerm_subnet.subnet.id
        private_ip_address_allocation = "Dynamic"
        public_ip_address_id          = azurerm_public_ip.public_ip.id
    }
}

resource "azurerm_network_security_group" "nsg" {
    name                = var.nsg_name
    location            = var.location
    resource_group_name = var.resource_group_name

    security_rule {
        name                       = "ssh"
        priority                   = 100
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "22"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
    }

    security_rule {
        name                       = "port-8000"
        priority                   = 200
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "8000"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
    }

    security_rule {
        name                       = "port-8081"
        priority                   = 201
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "8081"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
    }

    security_rule {
        name                       = "port-8082"
        priority                   = 202
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "8082"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
    }

    security_rule {
        name                       = "port-8083"
        priority                   = 203
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "8083"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
    }

    security_rule {
        name                       = "port-80"
        priority                   = 204
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "80"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
    }

    security_rule {
        name                       = "port-81"
        priority                   = 205
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "81"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
    }

    security_rule {
        name                       = "port-9411"
        priority                   = 206
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "9411"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
    }

    depends_on = [azurerm_resource_group.rg]

}

resource "azurerm_network_interface_security_group_association" "nic_nsg" {
    network_interface_id      = azurerm_network_interface.nic.id
    network_security_group_id = azurerm_network_security_group.nsg.id

    depends_on = [
        azurerm_subnet.subnet,
        azurerm_public_ip.public_ip
    ]

}

resource "azurerm_linux_virtual_machine" "vm" {
    name                = var.vm_name
    resource_group_name = var.resource_group_name
    location            = var.location
    size                = var.vm_size
    admin_username      = var.admin_username
    admin_password      = var.admin_password
    disable_password_authentication = false
    network_interface_ids = [azurerm_network_interface.nic.id]

    os_disk {
        caching              = "ReadWrite"
        storage_account_type = var.os_disk_storage_type
    }

    source_image_reference {
        publisher = var.image_publisher
        offer     = var.image_offer
        sku       = var.image_sku
        version   = var.image_version
    }

    provision_vm_agent = true
    custom_data        = base64encode(file("cloud-init.sh"))

    depends_on = [azurerm_network_interface.nic]
}
