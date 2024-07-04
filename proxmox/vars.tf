#variables
variable "PM_API_URL" {
  type = string
}

variable "PM_HOST" {
  type = string
}

variable "PM_USER" {
  type = string
}

variable "PM_KEY" {
  type      = string
  sensitive = true
}

variable "LXC_PASS" {
  type      = string
  sensitive = true
}

variable "LXC_HOSTNAME" {
  type = string
}

variable "target_node" {
  type = string
}

variable "template_name" {
  type = string
}

variable "pub_ssh_key" {
  type = string
}

variable "storage" {
  type = string
}
