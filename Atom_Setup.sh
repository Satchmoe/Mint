#!/bin/bash
######################################################################
# Program: Insatll Atom and packages for python programing
# Programmer: Chevelle
# Date crated: 12-23-2017
# Date Updated: 12-24-2017
# Update note: 
# Version : 1.1.0 (major.minor.fixes)
# Tested: Antix Linux 17 = worked
# Purpose: To install Atom and packages for python on Antix Linux
# Description:
# Notes:
######################################################################

function title() {
	# function to add title format
	clear
	echo
	echo "------------------------------------------"
	echo "	$1"
	echo "------------------------------------------"
	echo
}

function installer() {
	# function installer for deb based platforms
	sudo apt install $1
}

function install_atom() {
	# function install Atom Editor
	wget https://github.com/atom/atom/releases/latest -O ~/Downloads/latest
	wget $(awk -F '[<>]' '/href=".*atom-amd64.deb/ {match($0,"href=\"(.*.deb)\"",a); print "https://github.com/" a[1]} ' ~/Downloads/latest) -O ~/Downloads/atom-amd64.deb
	cd ~/Downloads
	sudo gdebi *.deb
}

function install_pip() {
	# function install pip
	installer python-dev build-essential python-setuptools python-pip
}

function install_pip_packages() {
	# function install pip packages
	sudo pip install autopep8 flake8
}

function install_atom_pacakages() {
	# fucntion install atom packages
	apm install linter-flake8 autocomplete-python busy-signal file-icons intentions linter linter-ui-default minimap python-autopep8 python-indent
}

title "Install Atom Y/N:"
echo "Enter your selection"
read a

if [[ $a == [yY] ]]; then

title "Need to insatll gdebi first"
installer gdebi git
title "Installing pip"
install_pip
title "Installing atom"
install_atom
title "Installing pip packages"
install_pip_packages
title "Installing atom packages for python"
install_atom_pacakages

title "Installation of Atom and packages is Compleated"
echo
echo
read -p "Press [Enter] to Exit..."
echo

else
	title "Exiting Installation"
	read -p "Press [Enter] to Exit..."
	echo
	
fi


