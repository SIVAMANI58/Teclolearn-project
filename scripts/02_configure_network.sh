#!/bin/bash
source ./env/dev.env

for VM in vm1 vm2 vm3; do
  sshpass -p "$SSH_PASS" ssh "$SSH_USER@$VM" <<EOF
sudo hostnamectl set-hostname $VM
echo "nameserver 8.8.8.8" | sudo tee /etc/resolv.conf
sudo netplan apply
EOF
done
