terraform {
  required_providers {
    proxmox = {
      source  = "telmate/proxmox"
      version = "3.0.1-rc3"
    }
  }
}

provider "proxmox" {

  pm_api_url = var.PM_API_URL

  # api token id is in the form of: <username>@pam!<tokenId>
  pm_api_token_id = var.PM_USER

  pm_api_token_secret = var.PM_KEY

  # leave tls_insecure set to true unless you have your proxmox SSL certificate situation fully sorted out (if you do, you will know)
  pm_tls_insecure = true

  pm_log_enable = false
  pm_log_file   = "terraform-plugin-proxmox.log"
  pm_parallel   = 1
  pm_timeout    = 600
  pm_debug      = true
  pm_log_levels = {
    _default    = "debug"
    _capturelog = ""
  }
}

