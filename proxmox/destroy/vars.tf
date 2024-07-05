#variables
variable "PM_API_URL" {
  description = "The URL of the Proxmox API."
  type        = string
}

variable "PM_HOST" {
  description = "The hostname or ip of the Proxmox host."
  type        = string
}

variable "PM_USER" {
  description = "The username and token string of the Proxmox user that will manage the infrastructure."
  type        = string
}

variable "PM_KEY" {
  description = "The API key of the Proxmox user."
  type        = string
  sensitive   = true
}

variable "target_node" {
  description = "The node on which the VM or LXC container is running."
  type        = string
}

variable "pub_ssh_key" {
  description = "The public SSH key to be added to the VM or LXC container."
  type        = string
}

variable "vm_id" {
  description = "The ID of the VM or LXC container to delete."
  type        = number
}

variable "resource_type" {
  description = "The type of resource to delete: vm or lxc."
  type        = string
}
