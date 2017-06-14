#!/usr/bin/env python3
""" Program: Install software for Linux Mint
    Programmer: Chevelle
    Date created: 06-12-2017
    Date Updated:
    Tested: Linux Mint 18.1 = worked
    Purpose: Fast way to install/configure new installed Mint distro
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
            print('Opening your Browser Up...')
            input('Press Enter to continue:')

        choice2 = str(input('Would you like to install "Teamviewer" [y/N]: '))
        if choice2 in ('y', 'ye', 'yes'):
            wb.open_new_tab('https://www.teamviewer.com/en/download/linux/')
            print('Opening your Browser Up...')
            input('Press Enter to continue:')

        input('Press Enter to continue installing Internet Software:')
        List.install(f'{deb_install} skype', 'Internet')

    def Tweaks():

        choice = str(input('Do you want to install Tweak software'
                           '[y=full/N=apps]: '))
        if choice in ('y', 'ye', 'yes'):
            List.install(f'{deb_install} conky conky-manager dconf-editor \
                        doublecmd-gkt', 'Tweak')

        menu()

    def Game():
        choice = str(input('Do you want to install just the apps or full setup'
                           '[y=full/N=apps]: '))
        if choice in ('y', 'ye', 'yes'):
            List.install(f'{deb_install} dosbox wine winetricks q4wine \
                        playonlinux smplayer gimp ttf-mscorefonts-installer \
                        ', 'Game-full')
            os.system('winetricks corefonts hosts winhttp wininet vcrun2015')
        else:
            List.install(f'{deb_install} dosbox wine winetricks q4wine \
                        playonlinux smplayer gimp \
                        ttf-mscorefonts-installer', 'Game')

        menu()

    def Software():
        List.install(f'{deb_install} ubuntu-restricted-extras libdvd-pkg catfish \
                    p7zip-rar vlc clementine inkscape shotwell shutter \
                    scribus', 'Software')

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
