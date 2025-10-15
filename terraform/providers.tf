terraform {
  required_providers {
    proxmox = {
      source = "bpg/proxmox"
        version = "0.85.1"
    }
  }
}

provider "proxmox" {
  endpoint    = var.pve_api_url
  api_token   = "${var.pve_token_id}=${var.pve_token_secret}"
  insecure    = true 
}