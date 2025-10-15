# SMKN 5 Malang TKJ Lab Environment Provisioning

This project utilizes Terraform to automate the provisioning of LXC containers on a Proxmox VE host. It is designed to
create a standardized environment for students, providing each group with their own container, user account, and a
specific set of permissions only to access their own group container/VM.

## Contents

The project uses [bpg/proxmox](https://registry.terraform.io/providers/bpg/proxmox/latest/docs) since it has more resources and fullfill the needs of the creator to automatically create and assign user to their own container.

The setup automatically creates:
- An LXC container for each student group.
- A dedicated user account for each group on Proxmox.
- A restricted role to ensure students only have access to their own virtual machine.
- Access Control Lists (ACLs) to tie permissions together.

## File Contents

```txt
terraform-proxmox/
└── terraform/  # Terraform configuration
└── studies/    # Study material made with Slidev
```
