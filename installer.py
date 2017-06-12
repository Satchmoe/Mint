#!/usr/bin/env python3
""" Program: Install software for Manjaro Linux
    Programmer: Chevelle
    Date created: 06-03-2017
    Date Updated:
    Tested: Manjaro Linux 17.0.1 = worked
    Purpose: Fast way to install/configure new installed Manjaro distro
    Description: Install software, configure wine on games side
"""

import os
import webbrowser as wb

deb_install = "sudo apt-get install"


class List(object):

    def install(install, name):
        print(f'Installing {name} Software...')
        try:
            os.system(install)
        except Exception as e:
            print('Error Installing')
        finally:
            input('\nEnter to continue:')
            menu()

    def Exit():
        os.system('clear')
        print('Exit!!! \n')

    def Development():
        List.install(f'{deb_install} geany', 'Development')

    def Internet():

        choice = str(input('Would you like to install "Google Chrome" [y/N]: '))
        if choice in ('y', 'ye', 'yes'):
            wb.open_new_tab('https://www.google.com/chrome/browser/desktop/index.html')
            input('Press Enter to continue:')

        choice2 = str(input('Would you like to install "Teamviewer" [y/N]: '))
        if choice2 in ('y', 'ye', 'yes'):
            wb.open_new_tab('https://www.teamviewer.com/en/download/linux/')
            input('Press Enter to continue:')

        input('Press Enter to continue installing Internet Software:')
        List.install(f'{deb_install} skype', 'Internet')

    def Tweaks():
        """Virtual memory tweaks for desktop..."""
        tweakList = {5: 'vm.dirty_background_ratio',
                     10: 'vm.swappiness',
                     15: 'vm.dirty_ratio',
                     70: 'vm.vfs_cache_pressure'
                     }

        for k, v, in tweakList.items():
            os.system(f'sudo echo -n "{v} = {k}" >> /etc/sysctl.conf')
            print(f'{v} = {k}.....Was changed...')

        os.sytem('sudo sed -i ''s/false/true/g'' /etc/apt/apt.conf.d/00recommends')

        choice = str(input('Do you want to install Tweak software'
                           '[y=full/N=apps]: '))
        if choice in ('y', 'ye', 'yes'):
            List.install(f'{deb_install} conky conky-manager dconf-editor \
                        doublecmd-gkt', 'Teak-Software')

        menu()

    def Game():
        choice = str(input('Do you want to install just the apps or full setup'
                           '[y=full/N=apps]: '))
        if choice in ('y', 'ye', 'yes'):
            List.install(f'{deb_install} dosbox wine winetricks q4wine \
                        playonlinux mono smplayer gimp lib32-libldap \
                        lib32-gnutls lib32-lcms2 ttf-ms-fonts gstreamer0.10-bad \
                        gstreamer0.10-bad-plugins gstreamer0.10-good \
                        gstreamer0.10-good-plugins gstreamer0.10-ugly \
                        gstreamer0.10-ugly-plugins gstreamer0.10-base \
                        gstreamer0.10-base-plugins \
                        ', 'Game-full')
            os.system('winetricks corefonts hosts winhttp wininet vcrun2015')
        else:
            List.install(f'{deb_install} dosbox wine winetricks q4wine \
                        playonlinux mono smplayer gimp lib32-libldap \
                        lib32-gnutls lib32-lcms2 ttf-ms-fonts', 'Game')

        menu()

    def Software():
        List.install(f'{deb_install} ubuntu-restricted-extras libdvd-pkg catfish \
                    p7zip-rar vlc clemintine inkscape shotwell shutter scribus')

    Menu_list = {0: Exit,
                 1: Development,
                 2: Internet,
                 3: Tweaks,
                 4: Game,
                 5: Software
                 }


def menu():
    """Display dictionary 'Menu_list' in List class as a menu"""
    os.system('clear')
    Selection = 1
    print('Installtion Menu for Linux Mint: \n')
    for k, v in List.Menu_list.items():
        print(k, '=', v.__name__)

    try:
        Selection = int(input("\nSelect a Number: "))
        if (Selection >= 0):
            List.Menu_list[Selection]()
    except Exception as e:
        print("Not a selection \nTry again: \n")
        input('Press Enter to continue....')
        menu()


def update():
    """Update repositorys and do a system update"""
    os.system('clear')

    choice = input('Would you like to Install 3rd party repositorys [y/N]: ')
    if choice in ('y', 'ye', 'yes'):
        os.system('sudo add-apt-repository ppa:webupd8team/atom && \
                sudo add-apt-repository ppa:ubuntuhandbook1/dvdstyler && \
                sudo add-apt-repository ppa:webupd8team/sublime-text-3 && \
                sudo add-apt-repository ppa:teejee2008/conky-manager')
        input('Press Enter to continue....')

    choice2 = input('Would you like to Update your system [y/N]: ')
    if choice2 in ('y', 'ye', 'yes'):
        os.system('sudo apt-get update && sudo apt-get upgrade')

    menu()


def main():
    update()


if __name__ == "__main__":
    main()
