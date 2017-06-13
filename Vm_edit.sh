#!/bin/bash
# Edit vitual memory for Linux Mint
# Tested on: 18.1
# Run as root.......

echo -n "vm.swappiness= 10" >> /etc/sysctl.conf
echo -n "vm.dirty_ratio = 15" >> /etc/sysctl.conf
echo -n "vm.vfs_cache_pressure = 70" >> /etc/sysctl.conf
echo -n "vm.dirty_background_ratio = 5" >> /etc/sysctl.conf
