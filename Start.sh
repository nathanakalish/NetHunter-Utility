#!/bin/sh
printf '\033[8;27;100t'
clear
#me="$(basename "$(test -L "$0" && readlink "$0" || echo "$0")")"

echo ${BASH_SOURCE[0]}

read -p "Is this a Mac or Linux computer? (Mac/Linux) "
case "$choice" in

mac|Mac|MAC )
clear
echo "No dependencies required. Contiuing..."
echo "";;

linux|Linux|LINUX )
clear
echo "Installing cURL via apt-get. Please enter your password when prompted!"
sudo apt-get -qq update && sudo apt-get -qq install curl
echo "";;
esac

echo "Downloading Lates KFU script..."
echo ""
curl -o ~/Desktop/kfu.sh 'https://0353c053bc2aaba73d57c10250836828c9338e1a.googledrive.com/host/0B4kCH1jSvs-QeUVlN3hVOFBGNTA'
clear
chmod 755 ~/Desktop/Kali/kfu.sh
sh ~/Desktop/kfu.sh