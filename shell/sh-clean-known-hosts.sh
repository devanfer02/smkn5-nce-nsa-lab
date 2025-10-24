#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/imports/colors.sh"

BASE_IP="172.16.23.10"

for i in {1..9}; do 
    ip_addr="$BASE_IP$i"
    
    printf '=%.0s' {1..65}; echo
    echo "Checking $ip_addr in known_hosts"
    res=$(cat  ~/.ssh/known_hosts | grep "$ip_addr")

    if [ -z "$res" ]; then 
        echo -e "${GREEN}IP Address: $ip_addr doesn't exist in known_hosts${NC}"
        continue 
    fi 

    echo -e "${ORANGE}IP Address: $ip_addr exists in known_hosts${NC}"
    echo -e "${ORANGE}Removing $ip_addr from known_hosts${NC}"

    ssh-keygen -R "$ip_addr"

    echo -e "${GREEN}$ip_addr removed from known_host${NC}"
done
