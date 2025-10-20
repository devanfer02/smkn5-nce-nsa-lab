resource "proxmox_virtual_environment_vm" "ubuntu_vm" {
  name      = "ubuntu-vm"
  node_name = "pve"
  vm_id     = 201

  initialization {
    datastore_id = "HDPVE"

    ip_config {
      ipv4 {
        address = "172.16.23.101/24"
        gateway = "172.16.23.254"
      }
    }

    user_account {
      keys     = var.ubuntu_sshkey_pub
      username = var.ubuntu_username
      password = var.ubuntu_password
    }
  }

  cpu {
    cores = 2
    type  = "x86-64-v2-AES"
  }

  memory {
    dedicated = 2048
    floating  = 2048
  }

  disk {
    datastore_id = "HDPVE"
    interface    = "scsi0"
    size         = 70
    import_from  = "HDPVE:import/jammy-server-cloudimg-amd64.qcow2"
  }

  network_device {
    bridge = "vmbr0"
  }
}
