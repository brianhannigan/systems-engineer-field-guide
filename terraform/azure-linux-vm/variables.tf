variable "resource_group_name" {
  description = "Azure resource group name."
  type        = string
  default     = "rg-sysadmin-field-guide-lab"
}

variable "location" {
  description = "Azure region."
  type        = string
  default     = "East US"
}

variable "name_prefix" {
  description = "Prefix used for resource naming."
  type        = string
  default     = "safg"
}

variable "vm_size" {
  description = "Azure VM size."
  type        = string
  default     = "Standard_B2s"
}

variable "admin_username" {
  description = "Admin username for the Linux VM."
  type        = string
  default     = "azureadmin"
}

variable "ssh_public_key" {
  description = "SSH public key for VM access."
  type        = string
}
