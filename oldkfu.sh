#!/bin/sh

printf '\033[8;27;100t'

clear
echo "Kali Flash Utility V4.3                                                              By Photonicgeek"
echo "####################################################################################################"
echo ""
echo ""
echo ""
echo ""
echo ""
echo ""
echo ""
echo "             THIS IS A UTILITY FOR THE NEXUS 7 (2013/2012) AND NEXUS 5 (2013) ON 4.4.4.             "
echo "                                IT WILL NOT WORK ON ANY OTHER DEVICE!                               "
echo ""
echo "                               If you want to continue, press [Enter].                              "
echo ""
echo ""
echo ""
echo ""
echo ""
echo ""
echo ""
echo ""
echo ""
echo ""
echo ""
echo ""
echo ""
read -p "           Thanks to droidshadow, Blinky, and Bruce2728 for the components and tutorials!           "
clear

echo "Kali Flash Utility V4.3                                                              By Photonicgeek"
echo "####################################################################################################"
echo ""

if [ -d ~/Desktop/Kali/ ]; then
echo "The installer has detected an existing Kali installer on the desktop. Keeping these files if"
read -p "damaged or incorrect can damage your device. Do you want to delete these files? (Y/N) " choice
case "$choice" in

y|Y )
rm -rf ~/Desktop/Kali
echo "Deleted! Continuing..."
mkdir ~/Desktop/Kali;;

n|N )
echo ""
echo "Ok! Continuing...";;

* )
echo "That wasn't a choice! Well, I'll delete them anyway"
rm -rf ~/Desktop/Kali && echo ""
echo "Deleted! Continuing...";;

esac
else
mkdir ~/Desktop/Kali
cd ~/Desktop/Kali
fi
clear

echo "Kali Flash Utility V4.3                                                              By Photonicgeek"
echo "####################################################################################################"
echo ""
if [ -d ~/Desktop/Kali/ ]; then
read -p "To continue, press [Enter]."
else
echo "The files to install everything will be downloaded to the desktop."
echo "If you kept the files from the previous step, just hit enter. It'll keep the files."
echo ""
read -p "To continue, press [Enter]."
fi
clear

cd ~/Desktop/Kali

###############################################################################################################################################
#####################################################################################################################################DOWNLOADS#
#########################################################################################################################################TOOLS#

echo "Kali Flash Utility V4.3                                                              By Photonicgeek"
echo "####################################################################################################"
echo ""
read -p "Is this a Mac or Linux computer? (Mac/Linux) " choice
case "$choice" in

linux|Linux )
clear
echo "Kali Flash Utility V4.3                                                              By Photonicgeek"
echo "####################################################################################################"
echo ""
echo "Downloading Linux Utilities:"
echo ""
sudo apt-get install curl
echo ""
echo "Downloading ADB (1/10)"
curl -o adb 'https://70743ecf11abb09cfe732ce2520f02a539906ddd.googledrive.com/host/0B4kCH1jSvs-QcTIxOWV0amQxdzA'
clear
echo "Kali Flash Utility V4.3                                                              By Photonicgeek"
echo "####################################################################################################"
echo ""
echo "Downloading Linux Utilities:"
echo ""
echo "Downloading Fastboot (2/10)"
echo ""
curl -o fastboot 'https://91174af3f1db07aef8930c4f6babd390eb02b66e.googledrive.com/host/0B4kCH1jSvs-QT2FCSFJNY1I4Uk0';;

mac|Mac )
clear
echo "Kali Flash Utility V4.3                                                              By Photonicgeek"
echo "####################################################################################################"
echo ""
echo "Downloading OS X Utilities:"
echo ""
echo "Downloading ADB (1/10)"
echo ""
curl -o adb 'https://8491183b033a3de769bb24c485b92b9ed599616b.googledrive.com/host/0B4kCH1jSvs-QTnZGVm1kVVRKZDQ'
clear
echo "Kali Flash Utility V4.3                                                              By Photonicgeek"
echo "####################################################################################################"
echo ""
echo "Downloading OS X Utilities:"
echo ""
echo "Downloading Fastboot (2/10)"
echo ""
curl -o fastboot 'https://9215f6bac4af104167c44fecdfa3f24e9168d51b.googledrive.com/host/0B4kCH1jSvs-QVmEtZWt4UDFoTW8';;

* )
echo ""
echo "Incorrect choice: Skipping.";;

esac
chmod 755 adb && chmod 755 fastboot
clear

###############################################################################################################################################
########################################################################################################################################DEVICE#

echo "Kali Flash Utility V4.3                                                              By Photonicgeek"
echo "####################################################################################################"
echo ""
read -p "Which device do you have? (FLO/DEB/Grouper/Tilapia/Hammerhead) " choice
case "$choice" in

###########################################################################################################################################DEB#

deb|DEB|Deb )
clear
echo "Kali Flash Utility V4.3                                                              By Photonicgeek"
echo "####################################################################################################"
echo ""
if [ -e ~/Desktop/Kali/TWRP.img ]; then
echo "File exists: Skipping"
else
echo "Downloading TWRP (3/10)"
echo ""
curl -o TWRP.img 'https://89b4b89a78d914af0e4312e1976f0d77ee9ec4c9.googledrive.com/host/0B4kCH1jSvs-QM1lycWJaMW4zNUU'
fi
clear

echo "Kali Flash Utility V4.3                                                              By Photonicgeek"
echo "####################################################################################################"
echo ""
if [ -e ~/Desktop/Kali/ROM.zip ]; then
echo "File Found: Skipping"
else
echo "Downloading OmniROM (4/10)"
echo ""
curl -o ROM.zip 'https://279bb97c5ae407f0795dbb15b0cf077283179b2d.googledrive.com/host/0B4kCH1jSvs-QcEdlcHktbjJiT2M'
fi
clear

echo "Kali Flash Utility V4.3                                                              By Photonicgeek"
echo "####################################################################################################"
echo ""
if [ -e ~/Desktop/Kali/Kernel.zip ]; then
echo "File Found: Skipping"
else
echo "Downloading Kernel (5/10)"
echo ""
curl -o Kernel.zip 'https://e7d96d2414a7050584e7f0df83348729ec2658a1.googledrive.com/host/0B4kCH1jSvs-QTVZZQUJBWFZnZ3M'
fi
clear

echo "Kali Flash Utility V4.3                                                              By Photonicgeek"
echo "####################################################################################################"
echo ""
if [ -e ~/Desktop/Kali/MultiROM.zip ]; then
echo "File Found: Skipping"
else
echo "Downloading MultiROM (6/10)"
echo ""
curl -o MultiROM.zip 'https://11377789dde55cdbe727b835190ac4ba464c0b54.googledrive.com/host/0B4kCH1jSvs-QVjRhREhwOEJoWTA'
fi
clear

echo "Kali Flash Utility V4.3                                                              By Photonicgeek"
echo "####################################################################################################"
echo ""
if [ -e ~/Desktop/Kali/BaseKernel.zip ]; then
echo "File Found: Skipping"
else
echo ""
read -p "Is your ROM based on CyanogenMod, or stock Android? (If in doubt, select stock) (CM/Stock/Keep) " kernel
case "$kernel" in

cm|CM|Cm )
clear
echo "Kali Flash Utility V4.3                                                              By Photonicgeek"
echo "####################################################################################################"
echo ""
echo "Downloading Base Kernel (CM) (7/10)"
curl -o BaseKernel.zip 'https://f7ff7aa4a003db7fa84ece768efa244b345ea7db.googledrive.com/host/0B4kCH1jSvs-QenR6LUxNV2VPc2c';;

stock|Stock|STOCK )
clear
echo "Kali Flash Utility V4.3                                                              By Photonicgeek"
echo "####################################################################################################"
echo ""
echo "Downloading Base Kernel (7/10)"
curl -o BaseKernel.zip 'https://1386c6afec610d0d42b9a7d0b7abe5ea002574c5.googledrive.com/host/0B4kCH1jSvs-QZDhKNkpJYndHUEk';;

keep|Keep|KEEP )
echo "";;

* )
echo ""
echo "That wasn't a choice! Quitting"
exit;;

esac
fi

clear;;

###########################################################################################################################################FLO#

FLO|flo|Flo )
clear
echo "Kali Flash Utility V4.3                                                              By Photonicgeek"
echo "####################################################################################################"
echo ""
if [ -e ~/Desktop/Kali/TWRP.img ]; then
echo "File exists: Skipping"
else
echo "Downloading TWRP (3/10)"
echo ""
curl -o TWRP.img 'https://126e7ec3b3feb20c17c3c1e5a7f5c4781d341e33.googledrive.com/host/0B4kCH1jSvs-QdVJCTUpmOFBxVFk'
fi
clear

echo "Kali Flash Utility V4.3                                                              By Photonicgeek"
echo "####################################################################################################"
echo ""
if [ -e ~/Desktop/Kali/ROM.zip ]; then
echo "File Found: Skipping"
else
echo "Downloading OmniROM (4/10)"
echo ""
curl -o ROM.zip 'https://173e702773312df15f15af4eb65963734f50b012.googledrive.com/host/0B4kCH1jSvs-QOTBnUmVRaGFnd1E'
fi
clear

echo "Kali Flash Utility V4.3                                                              By Photonicgeek"
echo "####################################################################################################"
echo ""
if [ -e ~/Desktop/Kali/Kernel.zip ]; then
echo "File Found: Skipping"
else
echo "Downloading Kernel (5/10)"
echo ""
curl -o Kernel.zip 'https://e7d96d2414a7050584e7f0df83348729ec2658a1.googledrive.com/host/0B4kCH1jSvs-QTVZZQUJBWFZnZ3M'
fi
clear

echo "Kali Flash Utility V4.3                                                              By Photonicgeek"
echo "####################################################################################################"
echo ""
if [ -e ~/Desktop/Kali/MultiROM.zip ]; then
echo "File Found: Skipping"
else
echo "Downloading MultiROM (6/10)"
echo ""
curl -o MultiROM.zip 'https://11377789dde55cdbe727b835190ac4ba464c0b54.googledrive.com/host/0B4kCH1jSvs-QVjRhREhwOEJoWTA'
fi
clear

echo "Kali Flash Utility V4.3                                                              By Photonicgeek"
echo "####################################################################################################"
echo ""
if [ -e ~/Desktop/Kali/BaseKernel.zip ]; then
echo "File Found: Skipping"
else
echo ""
read -p "Is your ROM based on CyanogenMod, or stock Android (If in doubt, select stock) (CM/Stock/Keep) " kernel
case "$kernel" in

cm|CM|Cm )
clear
echo "Kali Flash Utility V4.3                                                              By Photonicgeek"
echo "####################################################################################################"
echo ""
echo "Downloading Base Kernel (CM) (7/10)"
curl -o BaseKernel.zip 'https://f7ff7aa4a003db7fa84ece768efa244b345ea7db.googledrive.com/host/0B4kCH1jSvs-QenR6LUxNV2VPc2c';;

stock|Stock|STOCK )
clear
echo "Kali Flash Utility V4.3                                                              By Photonicgeek"
echo "####################################################################################################"
echo ""
echo "Downloading Base Kernel (7/10)"
curl -o BaseKernel.zip 'https://1386c6afec610d0d42b9a7d0b7abe5ea002574c5.googledrive.com/host/0B4kCH1jSvs-QZDhKNkpJYndHUEk';;

keep|Keep|KEEP )
echo "";;

* )
echo ""
echo "That wasn't a choice! Quitting"
exit;;

esac
fi

clear;;

#######################################################################################################################################GROUPER#

Grouper|grouper|GROUPER )
clear
echo "Kali Flash Utility V4.3                                                              By Photonicgeek"
echo "####################################################################################################"
echo ""
if [ -e ~/Desktop/Kali/TWRP.img ]; then
echo "File exists: Skipping"
else
echo "Downloading TWRP (3/10)"
echo ""
curl -o TWRP.img 'https://a0e0043c40ded627c45e16fa3fcbac32c710c462.googledrive.com/host/0B4kCH1jSvs-QclhHdXZ4U2lzLTQ'
fi
clear

echo "Kali Flash Utility V4.3                                                              By Photonicgeek"
echo "####################################################################################################"
echo ""
if [ -e ~/Desktop/Kali/ROM.zip ]; then
echo "File Found: Skipping"
else
echo "Downloading OmniROM (4/10)"
echo ""
curl -o ROM.zip 'https://c989d9d00585c516416e2d55c99ad8d2faa27f5a.googledrive.com/host/0B4kCH1jSvs-QVW01eFYwZWplOE0'
fi
clear

echo "Kali Flash Utility V4.3                                                              By Photonicgeek"
echo "####################################################################################################"
echo ""
if [ -e ~/Desktop/Kali/Kernel.zip ]; then
echo "File Found: Skipping"
else
echo "Downloading Kernel (5/10)"
echo ""
curl -o Kernel.zip 'https://4727ff79969b63d99112bb5c6f33b73e83251cf8.googledrive.com/host/0B4kCH1jSvs-QVGpObDFkSGN0VlU'
fi
clear

echo "Kali Flash Utility V4.3                                                              By Photonicgeek"
echo "####################################################################################################"
echo ""
if [ -e ~/Desktop/Kali/MultiROM.zip ]; then
echo "File Found: Skipping"
else
echo "Downloading MultiROM (6/10)"
echo ""
curl -o MultiROM.zip 'https://fe099fe4fd57588989cfbd8f8cbe982780f45d2a.googledrive.com/host/0B4kCH1jSvs-QYUp4NHZMeG9NMWs'
fi
clear

echo "Kali Flash Utility V4.3                                                              By Photonicgeek"
echo "####################################################################################################"
echo ""
if [ -e ~/Desktop/Kali/BaseKernel.zip ]; then
echo "File Found: Skipping"
else
echo ""
read -p "Is your ROM based on CyanogenMod, or stock Android (If in doubt, select stock) (CM/Stock/Keep) " kernel
case "$kernel" in

cm|CM|Cm )
clear
echo "Kali Flash Utility V4.3                                                              By Photonicgeek"
echo "####################################################################################################"
echo ""
echo "Downloading Base Kernel (CM) (7/10)"
curl -o BaseKernel.zip 'https://da725fd3009572f2e674df55fc00e864914c4e54.googledrive.com/host/0B4kCH1jSvs-QU2t5MS1LckZLME0';;

stock|Stock|STOCK )
clear
echo "Kali Flash Utility V4.3                                                              By Photonicgeek"
echo "####################################################################################################"
echo ""
echo "Downloading Base Kernel (7/10)"
curl -o BaseKernel.zip 'https://205cb8168f8c53f6b659a1eb922e3aa10fcf8fa5.googledrive.com/host/0B4kCH1jSvs-Qb2xtY0ppM1JjcFk';;

keep|Keep|KEEP )
echo "";;

* )
echo ""
echo "That wasn't a choice! Quitting"
exit;;

esac
fi

clear;;

#######################################################################################################################################TILAPIA#

Tilapia|tilapia|TILAPIA )
clear
echo "Kali Flash Utility V4.3                                                              By Photonicgeek"
echo "####################################################################################################"
echo ""
if [ -e ~/Desktop/Kali/TWRP.img ]; then
echo "File exists: Skipping"
else
echo "Downloading TWRP (3/10)"
echo ""
curl -o TWRP.img 'https://cc0f127354545ebd0c322f928f937c914ab9572a.googledrive.com/host/0B4kCH1jSvs-QLUZXRGw3UmFHeWM'
fi
clear

echo "Kali Flash Utility V4.3                                                              By Photonicgeek"
echo "####################################################################################################"
echo ""
if [ -e ~/Desktop/Kali/ROM.zip ]; then
echo "File Found: Skipping"
else
echo "Downloading OmniROM (4/10)"
echo ""
curl -o ROM.zip 'https://e72fa73ea9d8908e3c09080997f1668a619cba64.googledrive.com/host/0B4kCH1jSvs-QNVdSajdtYThjQ2s'
fi
clear

echo "Kali Flash Utility V4.3                                                              By Photonicgeek"
echo "####################################################################################################"
echo ""
if [ -e ~/Desktop/Kali/Kernel.zip ]; then
echo "File Found: Skipping"
else
echo "Downloading Kernel (5/10)"
echo ""
curl -o Kernel.zip 'https://4727ff79969b63d99112bb5c6f33b73e83251cf8.googledrive.com/host/0B4kCH1jSvs-QVGpObDFkSGN0VlU'
fi
clear

echo "Kali Flash Utility V4.3                                                              By Photonicgeek"
echo "####################################################################################################"
echo ""
if [ -e ~/Desktop/Kali/MultiROM.zip ]; then
echo "File Found: Skipping"
else
echo "Downloading MultiROM (6/10)"
echo ""
curl -o MultiROM.zip 'https://fe099fe4fd57588989cfbd8f8cbe982780f45d2a.googledrive.com/host/0B4kCH1jSvs-QYUp4NHZMeG9NMWs'
fi
clear

echo "Kali Flash Utility V4.3                                                              By Photonicgeek"
echo "####################################################################################################"
echo ""
if [ -e ~/Desktop/Kali/BaseKernel.zip ]; then
echo "File Found: Skipping"
else
echo ""
read -p "Is your ROM based on CyanogenMod, or stock Android (If in doubt, select stock) (CM/Stock/Keep) " kernel
case "$kernel" in

cm|CM|Cm )
clear
echo "Kali Flash Utility V4.3                                                              By Photonicgeek"
echo "####################################################################################################"
echo ""
echo "Downloading Base Kernel (CM) (7/10)"
curl -o BaseKernel.zip 'https://da725fd3009572f2e674df55fc00e864914c4e54.googledrive.com/host/0B4kCH1jSvs-QU2t5MS1LckZLME0';;

stock|Stock|STOCK )
clear
echo "Kali Flash Utility V4.3                                                              By Photonicgeek"
echo "####################################################################################################"
echo ""
echo "Downloading Base Kernel (7/10)"
curl -o BaseKernel.zip 'https://205cb8168f8c53f6b659a1eb922e3aa10fcf8fa5.googledrive.com/host/0B4kCH1jSvs-Qb2xtY0ppM1JjcFk';;

keep|Keep|KEEP )
echo "";;

* )
echo ""
echo "That wasn't a choice! Quitting"
exit;;

esac
fi

clear;;

####################################################################################################################################HAMMERHEAD#

Hammerhead|hammerhead|HAMMERHEAD )
clear
echo "Kali Flash Utility V4.3                                                              By Photonicgeek"
echo "####################################################################################################"
echo ""
if [ -e ~/Desktop/Kali/TWRP.img ]; then
echo "File exists: Skipping"
else
echo "Downloading TWRP (3/10)"
echo ""
curl -o TWRP.img 'https://d2581b691cf0508481f99e24d819a60a9a4e76ab.googledrive.com/host/0B4kCH1jSvs-QVGVibWRpRzNEclk'
fi
clear

echo "Kali Flash Utility V4.3                                                              By Photonicgeek"
echo "####################################################################################################"
echo ""
if [ -e ~/Desktop/Kali/ROM.zip ]; then
echo "File Found: Skipping"
else
echo "Downloading OmniROM (4/10)"
echo ""
curl -o ROM.zip 'https://a955d2b93439dfd6cf44a993014187e0043ec332.googledrive.com/host/0B4kCH1jSvs-QYUJDYUhreDdoU2M'
fi
clear

echo "Kali Flash Utility V4.3                                                              By Photonicgeek"
echo "####################################################################################################"
echo ""
if [ -e ~/Desktop/Kali/Kernel.zip ]; then
echo "File Found: Skipping"
else
echo "Downloading Kernel (5/10)"
echo ""
curl -o Kernel.zip 'https://7150685e2695e874e86f7af50516057c8f1f65a0.googledrive.com/host/0B4kCH1jSvs-QbF9peGVnZkpxaWc'
fi
clear

echo "Kali Flash Utility V4.3                                                              By Photonicgeek"
echo "####################################################################################################"
echo ""
if [ -e ~/Desktop/Kali/MultiROM.zip ]; then
echo "File Found: Skipping"
else
echo "Downloading MultiROM (6/10)"
echo ""
curl -o MultiROM.zip 'https://0975d5454125a1b92fbd39cb4543cc1d474e1429.googledrive.com/host/0B4kCH1jSvs-QeWpXb3k5LU44SlE'
fi
clear

echo "Kali Flash Utility V4.3                                                              By Photonicgeek"
echo "####################################################################################################"
echo ""
if [ -e ~/Desktop/Kali/BaseKernel.zip ]; then
echo "File Found: Skipping"
else
echo ""
read -p "Is your ROM based on CyanogenMod, or stock Android (If in doubt, select stock) (CM/Stock/Keep) " kernel
case "$kernel" in

cm|CM|Cm )
clear
echo "Kali Flash Utility V4.3                                                              By Photonicgeek"
echo "####################################################################################################"
echo ""
echo "Downloading Base Kernel (CM) (7/10)"
curl -o BaseKernel.zip 'https://16ca9e11ede561ea3a33f363ce79cbec29519769.googledrive.com/host/0B4kCH1jSvs-QX09rWlhWcG4tRUk';;

stock|Stock|STOCK )
clear
echo "Kali Flash Utility V4.3                                                              By Photonicgeek"
echo "####################################################################################################"
echo ""
echo "Downloading Base Kernel (7/10)"
curl -o BaseKernel.zip 'https://b6e3c57ab255ea8be11083911c9a01d1c0916db0.googledrive.com/host/0B4kCH1jSvs-QNWJRRS16U2oyemc';;

keep|Keep|KEEP )
echo "";;

* )
echo ""
echo "That wasn't a choice! Quitting"
exit;;

esac
fi

clear;;

#######################################################################################################################################UNKNOWN#

* )
echo "Incorrect choice. Exiting."
exit;;

esac

###############################################################################################################################################
###########################################################################################################################################ALL#

echo "Kali Flash Utility V4.3                                                              By Photonicgeek"
echo "####################################################################################################"
echo ""
if [ -e ~/Desktop/Kali/GApps.zip ]; then
echo "File Found: Skipping"
else
echo "Downloading GApps (8/10)"
echo ""
curl -o GApps.zip 'https://5c2c32adaaf9940a8241b5118ad1189f700c1598.googledrive.com/host/0B4kCH1jSvs-QVng4aFg1eGh2elU'
fi
clear

echo "Kali Flash Utility V4.3                                                              By Photonicgeek"
echo "####################################################################################################"
echo ""
if [ -e ~/Desktop/Kali/UPDATE-SuperSU-v2.00-2.zip ]; then
echo "File Found: Skipping"
else
echo "Moving SuperSU (9/10)"
echo ""

sleep 10
mv ~/Downloads/UPDATE-SuperSU-v2.02.zip ~/Desktop/Kali/SU.zip
fi
clear

echo "Kali Flash Utility V4.3                                                              By Photonicgeek"
echo "####################################################################################################"
echo ""
if [ -e ~/Desktop/Kali/Utilities.zip ]; then
echo "File Found: Skipping"
else
echo "Downloading Kali Utilities (10/10)"
echo ""
echo "This could take a while!"
echo ""
curl -o Utilities.zip 'https://33e44a405621e42b18580154364b86c6dc35122b.googledrive.com/host/0B4kCH1jSvs-QcUpYYlRPMFdEenM'
fi
clear

###############################################################################################################################################
######################################################################################################################################FLASHING#
###############################################################################################################################################

echo "Kali Flash Utility V4.3                                                              By Photonicgeek"
echo "####################################################################################################"
echo ""
echo "All files have been downloaded! To start, turn your tablet COMPLETELY off."
echo ""
read -p "To continue, press [Enter]."
clear

echo "Kali Flash Utility V4.3                                                              By Photonicgeek"
echo "####################################################################################################"
echo ""
echo "Press and hold both the volume down and power keys to get to the bootloader."
echo "It should have a large arrow at the top, and text near the bottom that says"
echo "'FASTBOOT MODE' in red"
echo ""
read -p "To continue, press [Enter]."
clear

echo "Kali Flash Utility V4.3                                                              By Photonicgeek"
echo "####################################################################################################"
echo ""
read -p "Is your bootloader unlocked (Does it show an unlocked lock icon when starting up?) (Y/N) " choice
case "$choice" in

y|Y )
clear
echo "Kali Flash Utility V4.3                                                              By Photonicgeek"
echo "####################################################################################################"
echo ""
echo "Flashing..."
./fastboot flash recovery TWRP.img;;

n|N )
clear
echo "Kali Flash Utility V4.3                                                              By Photonicgeek"
echo "####################################################################################################"
echo ""
tput setaf 1
echo "####################################################################################################"
echo "In order to continue, all data on your existing ROM MUST BE DELETED!!!"
echo "####################################################################################################"
tput setaf 0
read -p "Continue? (Y/N) " choice
case "$choice" in

y|Y )
echo ""
echo "When prompted, select 'Yes'"
./fastboot oem unlock
./fastboot reboot
clear
echo "Kali Flash Utility V4.3                                                              By Photonicgeek"
echo "####################################################################################################"
echo ""
echo "Set up the device like normal and then reboot back into the bootloader by pressing and holding the"
echo "power and volume down keys. You MUST set the device up again!!! Go Ahead... I'll wait."
./fastboot flash recovery TWRP.img;;

n|N )
clear
exit;;

esac
esac

clear

./fastboot boot ~/Desktop/Kali/TWRP.img

echo "Kali Flash Utility V4.3                                                              By Photonicgeek"
echo "####################################################################################################"
echo ""
echo "Select 'Advanced>ADB Sideload', then"
echo "'Swipe to Start Sideload'"
echo ""
read -p "To continue, press [Enter]."
clear

case "$kernel" in

keep|Keep|KEEP )
echo "Kali Flash Utility V4.3                                                              By Photonicgeek"
echo "####################################################################################################"
echo ""
echo "Skipping Base Kernel"
clear;;

* )
echo "Kali Flash Utility V4.3                                                              By Photonicgeek"
echo "####################################################################################################"
echo ""
echo "Uploading to device"
./adb sideload BaseKernel.zip
echo "Upload Complete."
echo ""
read -p "When the device is finished flashing, press [Enter]."
clear

echo "Kali Flash Utility V4.3                                                              By Photonicgeek"
echo "####################################################################################################"
echo ""
read -p "Did flashing succeed? (Y/N) " choice
case "$choice" in

y|Y )
clear;;

n|N )
clear
echo "Kali Flash Utility V4.3                                                              By Photonicgeek"
echo "####################################################################################################"
echo ""
echo "Uploading to device"
./adb sideload BaseKernel.zip
echo "Upload Complete."
echo ""
read -p "When the device is finished flashing, press [Enter]. If it did not succeed, please flash manually."
clear;;
esac

echo "Kali Flash Utility V4.3                                                              By Photonicgeek"
echo "####################################################################################################"
echo ""
echo "Press the home button at the bottom-left of the screen and tap 'Advanced>ADB Sideload', then"
echo "'Swipe to Start Sideload'"
echo ""
read -p "To continue, press [Enter]."
clear;;

esac

echo "Kali Flash Utility V4.3                                                              By Photonicgeek"
echo "####################################################################################################"
echo ""
echo "Uploading to device"
./adb sideload MultiROM.zip
echo "Upload Complete."
echo ""
read -p "When the device is finished flashing, press [Enter]."
clear

echo "Kali Flash Utility V4.3                                                              By Photonicgeek"
echo "####################################################################################################"
echo ""
read -p "Did flashing succeed? (Y/N) " choice
case "$choice" in

y|Y )
clear;;

n|N )
clear
echo "Kali Flash Utility V4.3                                                              By Photonicgeek"
echo "####################################################################################################"
echo ""
echo "Uploading to device"
./adb sideload MultiROM.zip
echo "Upload Complete."
echo ""
read -p "When the device is finished flashing, press [Enter]. If it did not succeed, please flash manually."
clear;;
esac

echo "Kali Flash Utility V4.3                                                              By Photonicgeek"
echo "####################################################################################################"
echo ""
echo "Press the home button at the bottom-left of the screen and tap"
echo "'Advanced>MultiROM>Add ROM'"
echo "Make sure 'Android', 'Don’t Share', and 'Internal Memory' are selected, and"
echo "press 'Next', then 'ADB Sideload'."
echo ""
read -p "To continue, press [Enter]."
clear

echo "Kali Flash Utility V4.3                                                              By Photonicgeek"
echo "####################################################################################################"
echo ""
echo "Uploading to device"
./adb sideload ROM.zip
echo "Upload Complete"
echo ""
read -p "When the device is finished flashing, press [Enter]."
clear

echo "Kali Flash Utility V4.3                                                              By Photonicgeek"
echo "####################################################################################################"
echo ""
read -p "Did flashing succeed? (Y/N) " choice
case "$choice" in

y|Y )
clear;;

n|N )
clear
echo "Kali Flash Utility V4.3                                                              By Photonicgeek"
echo "####################################################################################################"
echo ""
echo "Uploading to device"
./adb sideload ROM.zip
echo "Upload Complete."
echo ""
read -p "When the device is finished flashing, press [Enter]. If it did not succeed, please flash manually."
clear;;
esac

echo "Kali Flash Utility V4.3                                                              By Photonicgeek"
echo "####################################################################################################"
echo ""
echo "Press the home button at the bottom-left of the screen and tap"
echo "'Advanced>MultiROM>List ROMs>Sideload>Rename'"
echo "and rename the ROM 'Kali' and press Go, then tap 'Kali'"
echo ""
read -p "To continue, press [Enter]."
clear

echo "Kali Flash Utility V4.3                                                              By Photonicgeek"
echo "####################################################################################################"
echo ""
echo "Tap the button that says 'Sideload'."
echo ""
read -p "To continue, press [Enter]."
clear

echo "Kali Flash Utility V4.3                                                              By Photonicgeek"
echo "####################################################################################################"
echo ""
echo "Uploading to device"
./adb sideload GApps.zip
echo "Upload Complete."
echo ""
read -p "When the device is finished flashing, press [Enter]."
clear

echo "Kali Flash Utility V4.3                                                              By Photonicgeek"
echo "####################################################################################################"
echo ""
read -p "Did flashing succeed? (Y/N) " choice
case "$choice" in

y|Y )
clear;;

n|N )
clear
echo "Kali Flash Utility V4.3                                                              By Photonicgeek"
echo "####################################################################################################"
echo ""
echo "Uploading to device"
./adb sideload GApps.zip
echo "Upload Complete."
echo ""
read -p "When the device is finished flashing, press [Enter]. If it did not succeed, please flash manually."
clear;;
esac

echo "Kali Flash Utility V4.3                                                              By Photonicgeek"
echo "####################################################################################################"
echo ""
echo "Press the back button in the bottom-right corner, Tap 'Kali' and tap"
echo "'Sideload' again."
echo ""
read -p "To continue, press [Enter]."
clear

echo "Kali Flash Utility V4.3                                                              By Photonicgeek"
echo "####################################################################################################"
echo ""
echo "Uploading to device"
./adb sideload SU.zip
echo "Upload Complete"
echo ""
read -p "When the device is finished flashing, press [Enter]."
clear

echo "Kali Flash Utility V4.3                                                              By Photonicgeek"
echo "####################################################################################################"
echo ""
read -p "Did flashing succeed? (Y/N) " choice
case "$choice" in

y|Y )
clear;;

n|N )
clear
echo "Kali Flash Utility V4.3                                                              By Photonicgeek"
echo "####################################################################################################"
echo ""
echo "Uploading to device"
./adb sideload UPDATE-SuperSU-v2.00-2.zip
echo "Upload Complete."
echo ""
read -p "When the device is finished flashing, press [Enter]. If it did not succeed, please flash manually."
clear;;
esac

echo "Kali Flash Utility V4.3                                                              By Photonicgeek"
echo "####################################################################################################"
echo ""
echo "Press the back button in the bottom-right corner, Tap 'Kali' and tap"
echo "'Sideload' again."
echo ""
read -p "To continue, press [Enter]."
clear

echo "Kali Flash Utility V4.3                                                              By Photonicgeek"
echo "####################################################################################################"
echo ""
echo "Uploading to device (This could take a while, around 30 minutes)."
tput setaf 1
echo "If the file finishes flashing and it says ‘Failed to extract Ramdisk', just"
echo "disregard it."
tput setaf 0
./adb sideload Utilities.zip
echo "Upload Complete"
echo ""
read -p "When the device is finished flashing, press [Enter]."
clear

echo "Kali Flash Utility V4.3                                                              By Photonicgeek"
echo "####################################################################################################"
echo ""
read -p "Did flashing succeed? (EXCEPT THE RAMDISK ISSUE!) (Y/N) " choice
case "$choice" in

y|Y )
clear;;

n|N )
clear
echo "Kali Flash Utility V4.3                                                              By Photonicgeek"
echo "####################################################################################################"
echo ""
echo "Uploading to device"
./adb sideload Utilities.zip
echo "Upload Complete."
echo ""
read -p "When the device is finished flashing, press [Enter]. If it did not succeed, please flash manually."
clear;;
esac

echo "Kali Flash Utility V4.3                                                              By Photonicgeek"
echo "####################################################################################################"
echo ""
echo "Press the back button in the bottom-right corner, Tap 'Kali' and tap"
echo "'Sideload' again."
echo ""
read -p "To continue, press [Enter]."
clear

echo "Kali Flash Utility V4.3                                                              By Photonicgeek"
echo "####################################################################################################"
echo ""
echo "Uploading to device"
./adb sideload Kernel.zip
echo "Upload Complete."
clear

echo "Kali Flash Utility V4.3                                                              By Photonicgeek"
echo "####################################################################################################"
echo ""
echo "If you have a FLO or DEB device, follow the instructions below. Grouper/Tilapia instructions still"
echo "need to be developed."
echo ""
echo "Tap 'Next'"
echo "Tap 'I Agree with these Terms Of Use'"
echo "Tap 'Next'"
echo "Tap 'Next'"
echo "Tap 'OK'"
echo "Tap 'Next'"
echo "Tap 'Next'"
echo "Tap 'Next'"
echo "Tap 'Next'"
echo "Tap 'Next'"
echo "Tap 'Next'"
echo "Tap 'Next'"
echo "Tap 'Next'"
echo "Tap 'Next'"
echo "Select 'Enable USB OTG+Charge mode'"
echo "Select 'Enable USB fastcharge'"
echo "Select 'Enable exFAT filesystem support'"
echo "Tap 'Next'"
echo "Tap 'Install ElementalX' and when it is done, tap 'Next', then 'Finish'."
echo ""
read -p "When the device is finished flashing, press [Enter]."
clear

echo "Kali Flash Utility V4.3                                                              By Photonicgeek"
echo "####################################################################################################"
echo ""
read -p "Did flashing succeed? (Y/N) " choice
case "$choice" in

y|Y )
clear;;

n|N )
clear
echo "Kali Flash Utility V4.3                                                              By Photonicgeek"
echo "####################################################################################################"
echo ""
echo "Uploading to device"
./adb sideload Kernel.zip
echo "Upload Complete."
echo ""
clear

echo "Kali Flash Utility V4.3                                                              By Photonicgeek"
echo "####################################################################################################"
echo ""
echo "If you have a FLO or DEB device, follow the instructions below. Grouper/Tilapia instructions still"
echo "need to be developed."
echo ""
echo "Tap 'Next'"
echo "Tap 'I Agree with these Terms Of Use'"
echo "Tap 'Next'"
echo "Tap 'Next'"
echo "Tap 'OK'"
echo "Tap 'Next'"
echo "Tap 'Next'"
echo "Tap 'Next'"
echo "Tap 'Next'"
echo "Tap 'Next'"
echo "Tap 'Next'"
echo "Tap 'Next'"
echo "Tap 'Next'"
echo "Tap 'Next'"
echo "Select 'Enable USB OTG+Charge mode'"
echo "Select 'Enable USB fastcharge'"
echo "Select 'Enable exFAT filesystem support'"
echo "Tap 'Next'"
echo "Tap 'Install ElementalX' and when it is done, tap 'Next', then 'Finish'."
echo ""
read -p "When the device is finished flashing, press [Enter]. If it did not succeed, please flash manually."
clear;;
esac

echo "Kali Flash Utility V4.3                                                              By Photonicgeek"
echo "####################################################################################################"
echo ""
echo "Press the 'Reboot System' button, and select 'Do not install’ if given the option."
echo ""
read -p "To continue, press [Enter]."
clear

echo "Kali Flash Utility V4.3                                                              By Photonicgeek"
echo "####################################################################################################"
 echo ""
echo "CONGRATULATIONS! You have made your tablet into a PwnPad!"
echo ""
read -p "Would you like to delete the installer files from the computer? (y/n)" choice
case "$choice" in
y|Y ) rm -rf ~/Desktop/Kali && echo "Deleted!";;
n|N ) echo "" && echo "Okie Dokie Lokie!";;
* ) echo "That wasn't a choice! Well, I'll leave the files there.";;
esac

echo ""
echo "Enjoy Pentesting!"
echo ""
read -p "To exit the script, press [Enter]."
clear
