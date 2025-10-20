#!/bin/bash

instances=$(terraform state list | grep 'proxmox_virtual_environment_container.group_debian_container\[')

replace_args=()
for i in $instances; do 
    replace_args+=(-replace="$i")
done 

terraform apply -var-file=proxmox.tfvars -auto-approve "${replace_args[@]}"
