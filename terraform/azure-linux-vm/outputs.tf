output "resource_group_name" {
  value = azurerm_resource_group.example.name
}

output "vm_name" {
  value = azurerm_linux_virtual_machine.example.name
}

output "public_ip" {
  value = azurerm_public_ip.example.ip_address
}
