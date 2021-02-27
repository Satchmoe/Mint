#!/bin/bash
# Edit vitual memory for Linux Mint
# Tested on: 20 = worked
# Run as root.......

echo "Check swappiness Y/N:"
read a

if [[ $a == [yY] ]]; then

	cat /proc/sys/vm/swappiness

else

	echo "vm.swappiness = 10" >> /etc/sysctl.conf
	echo "vm.dirty_ratio = 3" >> /etc/sysctl.conf
	echo "vm.vfs_cache_pressure = 50" >> /etc/sysctl.conf
	echo "vm.dirty_background_ratio = 5" >> /etc/sysctl.conf
	echo "vm.watermark_scale_factor = 200" >> /etc/sysctl.conf

	echo "All Done"
	echo
	echo "Hit Enter to continue"
	read c
fi