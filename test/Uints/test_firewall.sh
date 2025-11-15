#!/bin/bash
source ./env/dev.env

for VM in vm1 vm2 vm3; do
  sshpass -p "$SSH_PASS" ssh "$SSH_USER@$VM" "sudo ufw status"
done
