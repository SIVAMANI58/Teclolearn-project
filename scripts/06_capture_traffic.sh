#!/bin/bash
source ./env/dev.env

sshpass -p "$SSH_PASS" ssh "$SSH_USER@vm1" <<EOF
sudo tcpdump -i eth0 -w traffic_vm1.pcap port 80 or port 5000
EOF
