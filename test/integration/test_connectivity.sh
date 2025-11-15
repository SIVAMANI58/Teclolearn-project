#!/bin/bash
source ./env/dev.env

ping -c 3 "$VM2_IP"
ping -c 3 "$VM3_IP"
curl "http://$VM1_IP/"
