variable "pve_token_id" {
  description = "Proxmox API Token Name"
  sensitive   = true
}

variable "pve_token_secret" {
  description = "Proxmox API Token Value"
  sensitive   = true
}

variable "pve_api_url" {
  description = "Proxmox API Endpoint"
  type        = string
  sensitive   = true
  validation {
    condition     = can(regex("(?i)^http[s]?://.*/api2/json$", var.pve_api_url))
    error_message = "Proxmox API Endpoint Invalid. Check URL - Scheme and Path required."
  }
}

variable "ubuntu_username" {
  description = "Ubuntu username for VM Access"
  type = string
  sensitive = true
}

variable "ubuntu_password" {
  description = "Ubuntu password for VM Access"
  type = string
  sensitive = true
}

variable "ubuntu_sshkey_pub" {
  description = "Ubuntu SSH Pub Key"
  type = list(string)
  default = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINrvRVRIzXaoNBOxYc8QYUzE955o02pHRH+tbsc15O0A ferrelvsc20@gmail.com"
  ]
}

variable "kelompok_list" {
  type = map(object({
    hostname = string
    password = string
    vm_id    = number
  }))
  default = {
    kelompok1 = { hostname = "kelompok1", password = "password1", vm_id = 101 }
    kelompok2 = { hostname = "kelompok2", password = "password2", vm_id = 102 }
    kelompok3 = { hostname = "kelompok3", password = "password3", vm_id = 103 }
    kelompok4 = { hostname = "kelompok4", password = "password4", vm_id = 104 }
    kelompok5 = { hostname = "kelompok5", password = "password5", vm_id = 105 }
    kelompok6 = { hostname = "kelompok6", password = "password6", vm_id = 106 }
    kelompok7 = { hostname = "kelompok7", password = "password7", vm_id = 107 }
    kelompok8 = { hostname = "kelompok8", password = "password8", vm_id = 108 }
  }
}
