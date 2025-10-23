# SMKN 5 Malang TKJ Lab Environment Provisioning

![img](./studies/04-webserver-hands-on/assets/infra.png)

This project utilizes Terraform to automate the provisioning of LXC containers on a Proxmox VE host and Ansible to provisioned Nginx study case material. It is designed to create a standardized environment for students, providing each group with their own container, user account, and a
specific set of permissions only to access their own group container.

## Contents

The project uses [bpg/proxmox](https://registry.terraform.io/providers/bpg/proxmox/latest/docs) since it has more resources and fullfill the needs of the creator to automatically create and assign user to their own container.

The [`terraform`](./terraform/) setup automatically creates:
- An LXC container for each student group.
- A dedicated user account for each group on Proxmox.
- A restricted role to ensure students only have access to their own virtual machine.
- Access Control Lists (ACLs) to tie permissions together.

The [`ansible`](./ansible/) setup automatically:
- Enabling root SSH login
- Fix issue LXC SSH Delay
- Install PHP, Nginx and MariaDB for study material
- Configured Laravel Webapp

## File Contents

```txt
smkn5-tkj-lab/
└── terraform/  # Terraform configuration
└── ansible/    # Ansible playbooks
└── studies/    # Study material
└── nginx/      # Nginx vhost config file
```

## Stacks

![My Skills](https://go-skill-icons.vercel.app/api/icons?i=proxmox,terraform,ansible,nginx,debian)