resource "proxmox_virtual_environment_container" "group_debian_container" {
  for_each = var.kelompok_list

  node_name   = "pve"
  tags        = ["debian", "student"]
  vm_id       = each.value.vm_id
  description = "Provisioning LXC for users"

  initialization {
    hostname = each.value.hostname

    dns {
      servers = [
        "8.8.8.8",
        "1.1.1.1"
      ]
    }

    ip_config {
      ipv4 {
        address = format("172.16.23.%d/24", each.value.vm_id)
        gateway = "172.16.23.254"
      }
    }

    user_account {
      password = each.value.password
      keys = var.ubuntu_sshkey_pub
    }
  }

  network_interface {
    name   = "virtio"
    bridge = "vmbr0"
  }

  cpu {
    cores = 1
  }

  memory {
    dedicated = 1024
  }

  disk {
    datastore_id = "HDPVE"
    size         = 20
  }

  operating_system {
    template_file_id = "HDPVE:vztmpl/debian-12-standard_12.7-1_amd64.tar.zst"
    type             = "debian"
  }
}

resource "proxmox_virtual_environment_user" "student_account" {
  for_each = var.kelompok_list
  user_id  = "${each.key}@pve"
  password = each.value.password

  acl {
    path      = "/vms/${each.value.vm_id}"
    role_id   = "student-role"
    propagate = true
  }

  depends_on = [ 
    proxmox_virtual_environment_role.student_role
   ]
}

resource "proxmox_virtual_environment_role" "student_role" {
  role_id = "student-role"

  privileges = [
    "VM.Audit",     # view their VM
    "VM.Console",   # open console
    "VM.Monitor",   # monitor status
    "VM.PowerMgmt", # start/stop/reboot
    "VM.Snapshot",  # manage snapshots 
  ]
}
