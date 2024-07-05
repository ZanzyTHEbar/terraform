resource "proxmox_lxc" "basic" {
  target_node     = var.target_node
  hostname        = var.LXC_HOSTNAME
  ostemplate      = var.template_name
  password        = var.LXC_PASS
  #unprivileged    = true
  memory          = 2048
  swap            = 2048
  cores           = 2
  ostype          = "ubuntu"
  onboot          = false
  start           = true
  ssh_public_keys = file("../${path.module}/keys/${var.pub_ssh_key}")

  rootfs {
    storage = var.storage
    size    = "16G"
  }

  network {
    name     = "eth0"
    bridge   = "vmbr0"
    ip       = "dhcp"
    firewall = true
  }
}

/* resource "null_resource" "modify_sshd_config" {
  depends_on = [proxmox_lxc.basic]

  provisioner "local-exec" {
    command = "${path.module}/scripts/setup_ssh.sh ${proxmox_lxc.basic.id} ${var.PM_HOST}"
  }
} */

