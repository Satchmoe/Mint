#!/bin/bash

####################################################################################
#		Program: Install software and secure linux-mint
#
#		Programmer: Chevelle
#		Date created: 9-11-2020
#		Date Updated: 2-15-2021
#
#		Update Notes: Added Battery Optimizer
#
#		Tested: With linux-mint 20.1 = Worked
#
#		Note:
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
	echo "1 = Brave Browser..."
	echo "2 = Secure..."
	echo "3 = Needed Software..."
	echo "4 = Conky..."
	echo "5 = Zsh..."
	echo "6 = Laptop Battery Optimizer..."
	echo "7 = Bpytop..."
	#echo "8 = Subllime Editor 64 or 32 bit..."
	#echo "8 = Remove unwanted software..."
	echo "8 = EXIT..."
	read b

		case $b in

			1)
				##### Brave-Browser #####

				title name "Brave-Browser"
				sudo apt install apt-transport-https curl gnupg
				echo
				curl -s https://brave-browser-apt-release.s3.brave.com/brave-core.asc | sudo apt-key --keyring /etc/apt/trusted.gpg.d/brave-browser-release.gpg add -
				echo
				echo "deb [arch=amd64] https://brave-browser-apt-release.s3.brave.com/ stable main" | sudo tee /etc/apt/sources.list.d/brave-browser-release.list
				echo
				sudo apt update
				sudo apt install brave-browser
				echo
				echo "Hit Enter to continue"
				read c

				;;
			2)
				##### Secure #####

				title_name "Secure"
				sudo apt update
				sudo apt install fail2ban ufw gufw
				echo
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
				sudo apt install clamtk basket geany terminator git mpv acetoneiso qdirstat bleachbit clementine notepadqq
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
				##### Battery Optimizer #####

				title_name "Install Laptop Battery Optimizer "
				sudo apt update
				sudo apt install tlp python3-gi git python3-setuptools python3-stdeb dh-python
				#-- install TLPUI
				git clone https://github.com/d4nj1/TLPUI
				cd TLPUI
				python3 setup.py --command-packages=stdeb.command bdist_deb
				sudo dpkg -i deb_dist/python3-tlpui_*all.deb
				echo
				#-- install auto-cpufreq
				cd ..
				git clone https://github.com/AdnanHodzic/auto-cpufreq.git
				cd auto-cpufreq && sudo ./auto-cpufreq-installer
				sudo auto-cpufreq --install
				echo
				echo "Dont forget to add TLPUI to the menu and check auto-cpufreq --stats"
				echo "Hit Enter to continue"
				read c

				;;

			7)
				##### Bpytop #####

				title_name "Install zsh"
				sudo apt install python3 python3-pip
				pip3 install bpytop --upgrade
				echo
				echo "Run Bpytop in terminal or add to menu"
				echo "Hit Enter to continue"
				read c


				;;

			8)
				#### Exit ####

				title_name "Good Bye!!!"
				exit

				;;

		esac

done
