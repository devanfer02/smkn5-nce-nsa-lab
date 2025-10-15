/*
See https://registry.terraform.io/providers/bpg/proxmox/latest/docs/resources/virtual_environment_container
for more documentation about variables and resources using bpg/proxmox provider
*/
resource "proxmox_virtual_environment_container" "group_debian_container" {

  for_each = var.kelompok_list

  node_name   = "pve"
  vm_id       = each.value.vm_id
  description = "Provisioning VM for users"

  initialization {
    hostname = each.value.hostname

    ip_config {
      ipv4 {
        address = "dhcp"
        gateway = var.gateway
      }
    }

    user_account {
      password = each.value.password
    }
  }

  network_interface {
    name = "virtio"
    bridge = var.network_bridge
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
    type = "debian"
  }

  start_on_boot = true
}

resource "proxmox_virtual_environment_user" "student_account" {
  for_each = var.kelompok_list
  user_id = "${each.key}@pve"
  password = "${each.value.password}"
}

resource "proxmox_virtual_environment_role" "student_role" {
  role_id = "student-role"

  privileges = [
    "VM.Audit",         # view their VM
    "VM.Console",       # open console
    "VM.Monitor",       # monitor status
    "VM.PowerMgmt",     # start/stop/reboot
    "VM.Snapshot",      # manage snapshots (optional)
  ]
}

resource "proxmox_virtual_environment_acl" "student_role_account" {
  for_each = var.kelompok_list

  user_id = "${each.key}@pve"
  role_id = "student-role"
  path = "/vms/${each.value.vm_id}"

  depends_on = [ 
    proxmox_virtual_environment_user.student_account,
    proxmox_virtual_environment_role.student_role
  ]
}