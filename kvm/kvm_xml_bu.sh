#!/bin/bash

read -p "hostname?" hostname

scp -r root@$hostname:/etc/libvirt/qemu . && mv qemu $hostname
