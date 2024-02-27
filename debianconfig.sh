#!/bin/bash

#Install XOrg
sudo apt install xorg

#Install sound
sudo apt install pulseaudio
sudo apt install alsa-utils
sudo apt install pavucontrol
sudo apt install pamixer

#Configure sound 
alsamixer -c 0
pamixer --get-volume-human
#If the output is muted run the following to unmute: 
pamixer -u

#Increase sound output gradually to 80 using pamixer -i 10 several times
pamixer -i 10
#Run alsamixer to check if it is indeed 80

#Install git
sudo apt install git

#Install Herbstluftwm
#Source: https://herbstluftwm.org/tutorial.html
#For the panel.sh to work verify that dzen2 is installed

sudo apt -y install herbstluftwm


#Install Firefox
#Source: https://linuxiac.com/how-to-install-the-latest-firefox-on-debian-12/

#Make sure that wget and curl are installed: sudo apt install wget curl

#Import Mozilla Repo’s Key

wget -q https://packages.mozilla.org/apt/repo-signing-key.gpg -O- | sudo tee /etc/apt/keyrings/packages.mozilla.org.asc > /dev/null

gpg -n -q --import --import-options import-show /etc/apt/keyrings/packages.mozilla.org.asc | awk '/pub/{getline; gsub(/^ +| +$/,""); print "\n"$0"\n"}'

#Add the Firefox Repo to your Debian 12 System

echo "deb [signed-by=/etc/apt/keyrings/packages.mozilla.org.asc] https://packages.mozilla.org/apt mozilla main" | sudo tee -a /etc/apt/sources.list.d/mozilla.list > /dev/null

#Prioritize Mozilla’s Repo

echo '
Package: *
Pin: origin packages.mozilla.org
Pin-Priority: 1000
' | sudo tee /etc/apt/preferences.d/mozilla

#Install Firefox from Mozilla’s Repo on Debian 12 Bookworm

sudo apt update

sudo apt install firefox


#CouchDB installation script
#Source: https://tecadmin.net/install-apache-couchdb-on-ubuntu/

sudo apt update 
sudo apt upgrade

#Enable CouchDB Repository

sudo apt install -y curl apt-transport-https gnupg

curl https://couchdb.apache.org/repo/keys.asc | gpg --dearmor | sudo tee /usr/share/keyrings/couchdb-archive-keyring.gpg >/dev/null 2>&1

source /etc/os-release

echo "deb [signed-by=/usr/share/keyrings/couchdb-archive-keyring.gpg] https://apache.jfrog.io/artifactory/couchdb-deb/ ${VERSION_CODENAME} main" \
    | sudo tee /etc/apt/sources.list.d/couchdb.list >/dev/null 

sudo apt update

#Install CouchDB
#Run ip a command first to identify your IP address. This will be a binding address for CouchDB
#For the secret cookie use: My Basic Password
#For the admin user name set password: My Basic Password

sudo apt install -y couchdb

#Verify the Installation
#curl http://my ip address:5984/ 

#Remove Couchdb: sudo apt -y remove couchdb

#Install firewall
sudo apt ufw


#Install pass 
sudo apt install pass

#Copy gpg files
#Create a mount point for the usb flash drive in ~/ directory
mkdir ~/usb
#Identify the usb drive 
lsblk -f
#Mount usb sde1 to ~/usb mount point
sudo mount /dev/sde1 ~/usb/
#Create a password storage directory
mkdir ~/.password-store
#Unmount usb drive 
sudo umount ~/usb

#Export secret keys for the pass utility
gpg --list-secret-keys
gpg --output MY_FILENAME_public.gpg --armor --export GPG_PUB_KEY
gpg --output MY_FILENAME_secret.gpg --armor --export-secret-key GPG_PUB_KEY
#Copy the output files to the usb flash drive
#Copy the files from the flash drive to the home directory 
#Import the secret keys
gpg --import MY_FILENAME_pub.gpg
gpg --allow-secret-key-import --import MY_FILENAME_sec.gpg

#Install Brave browser. Source https://brave.com/linux/
sudo apt update 
sudo apt upgrade 
sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg] https://brave-browser-apt-release.s3.brave.com/ stable main"|sudo tee /etc/apt/sources.list.d/brave-browser-release.list
sudo apt update
sudo apt install brave-browser

#Install Yandex browser. Source: https://yandex.com/support/browser-beta/about/install.html
sudo apt install software-properties-common
sudo add-apt-repository "deb https://repo.yandex.ru/yandex-browser/deb beta main"
curl https://repo.yandex.ru/yandex-browser/YANDEX-BROWSER-KEY.GPG --output YANDEX-BROWSER-KEY.GPG
#Reportedly this is depriciated. Needs to find out what is the modern way to add a key
sudo apt-key add YANDEX-BROWSER-KEY.GPG
#Open Firefox  https://browser.yandex.ru/beta/ and download and download Yandex.deb. The file will be dowloaded to ~/Downloads
#Install gdebi
sudo apt update 
sudo apt install gdebi
sudo gdebi ~/Downloads/Yandex.deb

#Install Rust. Source: https://www.rust-lang.org/tools/install
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

#The output is the following: 
#Welcome to Rust!

#This will download and install the official compiler for the Rust
#programming language, and its package manager, Cargo.

#Rustup metadata and toolchains will be installed into the Rustup
#home directory, located at:

#  /home/azavgo/.rustup

#This can be modified with the RUSTUP_HOME environment variable.

#The Cargo home directory is located at:

#  /home/azavgo/.cargo

#This can be modified with the CARGO_HOME environment variable.

#The cargo, rustc, rustup and other commands will be added to
#Cargo's bin directory, located at:

#  /home/azavgo/.cargo/bin

#This path will then be added to your PATH environment variable by
#modifying the profile files located at:

#  /home/azavgo/.profile
#  /home/azavgo/.bashrc

#You can uninstall at any time with rustup self uninstall and
#these changes will be reverted.

#Current installation options:


#   default host triple: x86_64-unknown-linux-gnu
#     default toolchain: stable (default)
#               profile: default
#  modify PATH variable: yes

#1) Proceed with installation (default)
#2) Customize installation
#3) Cancel installation


#Install java to run tastytrade jre files
sudo apt update
sudo apt install default-jre

#Install tastytrade platform. Source: https://tastytrade.com/trading-platforms/
#Download tastytrade deb file

#Create desktop-directories, this is simply to fix some old linux bug
sudo mkdir /usr/share/desktop-directories

#Now install tastytrade
sudo gdebi ~/Downloads/tastytrade-2.9.0-1_amd64.deb
#java -jar tastytrade-2.9.0.-1_amd64.jar

#Add path to the tastytrade executable file for rofi app launcher
#sudo vim ~/.bashrc
#Add in the end of the file: export PATH="/opt/tastytrade/bin:$PATH"



