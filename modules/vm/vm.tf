resource "azurerm_network_interface" "vm01" {
  name                = var.nic01_name
  location            = var.location
  resource_group_name = var.rg_name

  ip_configuration {
    name                          = var.ipconf1_name
    subnet_id                     = var.sub1_id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_virtual_machine" "vm01" {
  name                  = var.vm01_name
  location              = var.location
  resource_group_name   = var.rg_name
  network_interface_ids = [azurerm_network_interface.vm01.id]
  vm_size               = var.vm01_size

  delete_os_disk_on_termination = true

  delete_data_disks_on_termination = true

  storage_image_reference {
    publisher = var.vm01_publisher
    offer     = var.vm01_offer
    sku       = var.vm01_sku
    version   = "latest"
  }
  storage_os_disk {
    name              = "myosdisk1"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }
  os_profile {
    computer_name  = "hostname"
    admin_username = var.vm01_username
    admin_password = var.vm01_userpswd
  }
  os_profile_linux_config {
    disable_password_authentication = false
  }
  tags = {
    environment = var.env
    project = var.project
  }
}


resource "azurerm_network_interface" "vm02" {
  name                = var.nic02_name
  location            = var.location
  resource_group_name = var.rg_name

  ip_configuration {
    name                          = var.ipconf2_name
    subnet_id                     = var.sub2_id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_windows_virtual_machine" "vm02" {
  name                = var.vm02_name
  resource_group_name = var.rg_name
  location            = var.location
  size                = var.vm02_size
  admin_username      = var.vm02_username
  admin_password      = var.vm02_userpswd
  network_interface_ids = [
    azurerm_network_interface.vm02.id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = var.vm02_publisher
    offer     = var.vm02_offer
    sku       = var.vm02_sku
    version   = "latest"
  }

  tags = {
    environment = var.env
    project = var.project
  }
}