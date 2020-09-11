#!/bin/bash
# Edit vitual memory for Linux Mint
# Tested on: 18.1 = worked
# Run as root.......

echo "vm.swappiness = 10" >> /etc/sysctl.conf
echo "vm.dirty_ratio = 3" >> /etc/sysctl.conf
echo "vm.vfs_cache_pressure = 50" >> /etc/sysctl.conf
echo "vm.dirty_background_ratio = 5" >> /etc/sysctl.conf
echo "vm.watermark_scale_factor = 200" >> /etc/sysctl.conf
