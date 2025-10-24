#!/bin/bash

USER="root"
BASE_IP="172.16.23.10"   

for i in {1..9}; do
    HOST="$BASE_IP$i"
    echo "Checking locks on $HOST..."
    
    ssh "$USER@$HOST" 'bash -s' <<'EOF'
        # check for process locking dpkg or apt
        LOCK_PROCS=$(lsof /var/lib/dpkg/lock-frontend /var/lib/apt/lists/lock /var/cache/apt/archives/lock 2>/dev/null | awk "NR>1 {print \$2}" | sort -u);

        if [ -z "$LOCK_PROCS" ]; then
            echo "No lock processes found.";
            exit 0;
        fi

        echo "Found lock processes: $LOCK_PROCS";
        for pid in $LOCK_PROCS; do
            echo "Killing process $pid";
            kill -9 $pid;
        done

        echo "All lock processes killed!";

        dpkg --configure -a
EOF

done
