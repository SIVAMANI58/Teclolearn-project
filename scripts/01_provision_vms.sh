#!/bin/bash
VM_NAMES=("vm1" "vm2" "vm3")
for VM in "${VM_NAMES[@]}"; do
  if ! virsh list --all | grep -q "$VM"; then
    echo "Creating $VM..."
    virt-install --name "$VM" --memory 2048 --vcpus 2 \
      --disk path=/var/lib/libvirt/images/"$VM".qcow2,size=10 \
      --os-type linux --os-variant ubuntu20.04 \
      --network network=default \
      --graphics none --console pty,target_type=serial \
      --location 'http://archive.ubuntu.com/ubuntu/dists/focal/main/installer-amd64/' \
      --extra-args 'console=ttyS0,115200n8 serial'
  else
    echo "$VM already exists."
  fi
done
