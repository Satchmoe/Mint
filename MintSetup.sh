#!/bin/bash

####################################################################################
#		Program: Install software and secure linux-mint
#
#		Programmer: Chevelle
#		Date created: 9-11-2020
#		Date Updated: 9-13-2020
*
*		Update Notes: Added qdirstat, acetoneiso,
#
#		Tested: With linux-mint 20 = Worked
#
#		Note: Run in sudo to get swappiness to work
#
#		Purpose: Faster way to install/configure new linux-mint
#
#		Description: install Software, secure, and zsh for linux-mint
#
####################################################################################

function title_name {
	# function to add title format
	clear
	echo "------------------------------"
	echo "$1"
	echo "------------------------------"
	echo

}

############## Start ############################

title_name "Linux-Mint Setup:"

############## install list #####################
while :
do

	title_name "Linux-Mint Setup:"
	echo "Dont forget your VPN"
	echo
	echo "1 = Swappiness..."
	echo "2 = Secure..."
	echo "3 = Needed Software..."
	echo "4 = Conky..."
	echo "5 = Zsh..."
	#echo "6 = Atom Editor 64 bit only..."
	#echo "7 = I3wm..."
	#echo "8 = Subllime Editor 64 or 32 bit..."
	#echo "8 = Remove unwanted software..."
	echo "6 = EXIT..."
	read b

		case $b in

			1)
				##### Swappiness #####

				title_name "Swappiness"
				echo "vm.swappiness = 10" >> /etc/sysctl.conf
				echo "vm.dirty_ratio = 3" >> /etc/sysctl.conf
				echo "vm.vfs_cache_pressure = 50" >> /etc/sysctl.conf
				echo "vm.dirty_background_ratio = 5" >> /etc/sysctl.conf
				echo "vm.watermark_scale_factor = 200" >> /etc/sysctl.conf
				echo
				echo "Hit Enter to continue"
				read c

				;;
			2)
				##### Secure #####

				title_name "Secure"
				# --- Setup UFW rules
				sudo ufw limit 22/tcp
				sudo ufw allow 80/tcp
				sudo ufw allow 443/tcp
				sudo ufw default deny incoming
				sudo ufw default allow outgoing
				sudo ufw enable

				# --- Harden /etc/sysctl.conf
				#sudo sysctl kernel.modules_disabled=1
				sudo sysctl -a
				sudo sysctl -A
				sudo sysctl mib
				sudo sysctl net.ipv4.conf.all.rp_filter
				sudo sysctl -a --pattern 'net.ipv4.conf.(eth|wlan)0.arp'

				# --- PREVENT IP SPOOFS
				echo "order bind,hosts" >> /etc/host.conf
				echo "multi on" >> /etc/host.conf

				# --- Enable fail2ban
				sudo cp fail2ban.local /etc/fail2ban/
				sudo systemctl enable fail2ban
				sudo systemctl start fail2ban

				echo "listening ports"
				sudo netstat -tunlp
				echo
				echo "Hit Enter to continue"
				read c

				;;
			3)
				##### Software #####

				title_name "Install needed Software"
				sudo apt update
				sudo apt install tlp fail2ban clamtk basket geany terminator git mpv acetoneiso qdirstat bleachbit clementine
				echo
				echo "Hit Enter to continue"
				read c

				;;

			4)
				##### Conky #####

				title_name "Install Conky"
				sudo add-apt-repository ppa:linuxmint-tr/araclar
				sudo apt update
				sudo apt install conky conky-all conky-manager conky-manager-extra
				echo
				echo "Hit Enter to continue"
				read c

				;;

			5)
				##### zsh #####

				title_name "Install zsh"
				sudo apt install zsh-syntax-highlighting autojump zsh-autosuggestions
				touch "$HOME/.cache/zshhistory"
				#-- Setup Alias in $HOME/zsh/aliasrc
				git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k
				echo 'source ~/powerlevel10k/powerlevel10k.zsh-theme' >> ~/.zshrc
				chsh $USER
				echo
				echo "Hit Enter to continue"
				read c


				;;

			6)
				#### Exit ####

				title_name "Good Bye!!!"
				exit

				;;

		esac

done
