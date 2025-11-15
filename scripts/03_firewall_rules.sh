#!/bin/bash
source ./env/dev.env

for VM in vm1 vm2 vm3; do
  sshpass -p "$SSH_PASS" ssh "$SSH_USER@$VM" <<EOF
sudo ufw default deny incoming
sudo ufw default allow outgoing
sudo ufw allow ssh
sudo ufw allow 80/tcp
sudo ufw allow 5000/tcp
sudo ufw --force enable
EOF
done
 