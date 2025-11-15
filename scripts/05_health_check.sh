#!/bin/bash
source ./env/dev.env

for VM in vm2 vm3; do
  sshpass -p "$SSH_PASS" ssh "$SSH_USER@$VM" <<EOF
if ! curl -s http://localhost:5000/health | grep -q "OK"; then
  echo "Restarting backend container on $VM"
  docker restart \$(docker ps -q --filter "ancestor=backend_service")
fi
EOF
done
