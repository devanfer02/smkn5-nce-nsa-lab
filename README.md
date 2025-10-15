# SMKN 5 Malang IaC Provisioning

This project utilizes Terraform to automate the provisioning of LXC containers on a Proxmox VE host. It is designed to
create a standardized environment for students, providing each group with their own container, user account, and a
specific set of permissions only to access their own group container/VM.

## Contents

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