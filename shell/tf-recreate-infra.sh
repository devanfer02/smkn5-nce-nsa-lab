#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/imports/colors.sh"

cd terraform

instances=$(terraform state list | grep 'proxmox_virtual_environment_container.group_debian_container\[')
accounts=$(terraform state list | grep 'proxmox_virtual_environment_user.student_account\[')

replace_args=()
for i in $instances; do 
    replace_args+=(-target="$i")
done 

for a in $accounts; do
    replace_args+=(-target="$a")
done 

terraform destroy -var-file=proxmox.tfvars -auto-approve "${replace_args[@]}"
terraform apply -var-file=proxmox.tfvars -auto-approve "${replace_args[@]}"

echo -e "${GREEN}All 9 student's group LXC and account already recreated!${RESET}"
