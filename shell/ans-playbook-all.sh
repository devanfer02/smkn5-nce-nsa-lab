#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/imports/colors.sh"

TOTAL_HOST=9
PLAYBOOKS=($(ls ansible/playbooks))

cd ansible || exit

echo "Checking all ansible hosts..."
count=$(ansible kelompok -m ping | grep -c "SUCCESS")

while [ $count -ne $TOTAL_HOST ]; do 
    echo -e "${YELLOW}Only $count hosts are reachable!${RESET}"
    echo -e "${YELLOW}Waiting for all $TOTAL_HOST hosts to be reachable...${RESET}"

    sleep 2
    $count=$(ansible kelompok -m ping | grep -c "SUCCESS")
done 

echo -e "${GREEN}All $TOTAL_HOST hosts are reachable!${RESET}"

for pbook in "${PLAYBOOKS[@]}"; do 
    printf '=%.0s' {1..65}; echo
    echo -e "${BLUE}Running playbook: $pbook${RESET}"
    ansible-playbook -e @inventory/vars.yaml "playbooks/$pbook"
done 

echo -e "${GREEN}All playbooks completed successfully!${RESET}"
