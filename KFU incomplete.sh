#!/bin/sh

#  KFU Rewritten.sh
#  
#
#  Created by Nathan Kalish on 8/20/14.
#
printf '\033[8;27;100t'
clear
echo "Kali Flash Utility V5.0                                                              By Photonicgeek"
echo "####################################################################################################"
echo ""
echo ""
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
read -p "    Thanks to droidshadow, Blinkybear, Tassadar, and Bruce2728 for the components and tutorials!    "
clear

#########
##SETUP##
#########

if [ -d ~/Desktop/Kali/ ]; then
read -p "There appears to be an existing run of the KFU utility. Do you want to delete these files? (Y/N) " deletefiles
case "$deletefiles" in

Y|y )
rm -rf ~/Desktop/Kali
echo ""
echo "Deleted! Continuing..."
sleep 2;;

N|n )
echo ""
echo "Keeping current files..."
sleep 2;;

* )
echo ""
echo "Unknown response! Exiting."
sleep 2
exit;;

esac
fi
clear

if [ -d ~/Desktop/Kali/ ]; then
echo ""
else
echo "The files needed to install Kali Linux will be downloaded to a folder on your desktop"
echo ""
read -p "Press [Enter] to continue"
mkdir ~/Desktop/Kali
cd ~/Desktop/Kali
fi
clear

############
##DOWNLOAD##
############

unamestr=`uname`
if [[ "$unamestr" == 'Darwin' ]]; then
echo "OS X operating system detected."
echo ""
echo "Downloading ADB (1/10)"
echo ""
curl -o adb 'https://8491183b033a3de769bb24c485b92b9ed599616b.googledrive.com/host/0B4kCH1jSvs-QTnZGVm1kVVRKZDQ'
echo ""
echo "Downloading Fastboot (2/10)"
curl -o fastboot 'https://9215f6bac4af104167c44fecdfa3f24e9168d51b.googledrive.com/host/0B4kCH1jSvs-QVmEtZWt4UDFoTW8'

else
echo "Linux-based OS detected."
echo ""
echo "Installing cURL (Password may be required)"
sudo apt-get -qq update && sudo apt-get -qq -y install curl
echo ""
echo "Downloading ADB (1/10)"
echo ""
curl -o adb 'https://70743ecf11abb09cfe732ce2520f02a539906ddd.googledrive.com/host/0B4kCH1jSvs-QcTIxOWV0amQxdzA'
echo ""
echo "Downloading Fastboot (2/10)"
echo ""
curl -o fastboot 'https://91174af3f1db07aef8930c4f6babd390eb02b66e.googledrive.com/host/0B4kCH1jSvs-QT2FCSFJNY1I4Uk0'
fi
clear

read -p "Which device do you have? (FLO/DEB/Grouper/Tilapia/Hammerhead) " device
case "$device" in

#######
##FLO##
#######

FLO|Flo|flo )

clear
echo ""
read -p "What is your current ROM based off of? (If in doubt, select AOSP) (CM/AOSP/Keep)" kernel
case "$kernel" in
esac
clear

if [ -e ~/Desktop/Kali/TWRP.img ]; then
echo ""
else
echo "Downloading TWRP recovery (3/10)"
echo ""
curl -o TWRP.img 'https://126e7ec3b3feb20c17c3c1e5a7f5c4781d341e33.googledrive.com/host/0B4kCH1jSvs-QdVJCTUpmOFBxVFk'
fi
clear

if [ -e ~/Desktop/Kali/ROM.zip ]; then
echo ""
else
echo "Downloading OmniROM (4/10)"
echo ""
curl -o ROM.zip 'https://173e702773312df15f15af4eb65963734f50b012.googledrive.com/host/0B4kCH1jSvs-QOTBnUmVRaGFnd1E'
fi
clear

if [ -e ~/Desktop/Kali/Kernel.zip ]; then
echo ""
else
echo "Downloading Kernel (5/10)"
echo ""
curl -o Kernel.zip 'https://e7d96d2414a7050584e7f0df83348729ec2658a1.googledrive.com/host/0B4kCH1jSvs-QTVZZQUJBWFZnZ3M'
fi
clear

if [ -e ~/Desktop/Kali/MultiROM.zip ]; then
echo ""
else
echo "Downloading MultiROM (6/10)"
echo ""
curl -o MultiROM.zip 'https://11377789dde55cdbe727b835190ac4ba464c0b54.googledrive.com/host/0B4kCH1jSvs-QVjRhREhwOEJoWTA'
fi
clear

if [ -e ~/Desktop/Kali/BaseKernel.zip ]; then
echo ""
else
if [[ "$kernel" == 'CM' || "$kernel" == 'cm' ]]; then
echo "Downloading modified kernel (CM) (7/10)"
echo ""
curl -o BaseKernel.zip 'https://f7ff7aa4a003db7fa84ece768efa244b345ea7db.googledrive.com/host/0B4kCH1jSvs-QenR6LUxNV2VPc2c'
elif [[ "$kernel" == 'AOSP' || "$kernel" == 'aosp' ]]; then
echo "Downloading modified kernel (AOSP) (7/10)"
echo ""
curl -o BaseKernel.zip 'https://1386c6afec610d0d42b9a7d0b7abe5ea002574c5.googledrive.com/host/0B4kCH1jSvs-QZDhKNkpJYndHUEk'
elif [[ "$kernel" == 'KEEP' || "$kernel" == 'Keep' || "$kernel" == 'keep' ]]; then
echo ""
fi
fi
clear;;

#######
##DEB##
#######

DEB|Deb|deb )

clear
echo ""
read -p "What is your current ROM based off of? (If in doubt, select AOSP) (CM/AOSP/Keep)" kernel
case "$kernel" in
esac
clear

if [ -e ~/Desktop/Kali/TWRP.img ]; then
echo ""
else
echo "Downloading TWRP recovery (3/10)"
echo ""
curl -o TWRP.img 'https://89b4b89a78d914af0e4312e1976f0d77ee9ec4c9.googledrive.com/host/0B4kCH1jSvs-QM1lycWJaMW4zNUU'
fi
clear

if [ -e ~/Desktop/Kali/ROM.zip ]; then
echo ""
else
echo "Downloading OmniROM (4/10)"
echo ""
curl -o ROM.zip 'https://279bb97c5ae407f0795dbb15b0cf077283179b2d.googledrive.com/host/0B4kCH1jSvs-QcEdlcHktbjJiT2M'
fi
clear

if [ -e ~/Desktop/Kali/Kernel.zip ]; then
echo ""
else
echo "Downloading Kernel (5/10)"
echo ""
curl -o Kernel.zip 'https://e7d96d2414a7050584e7f0df83348729ec2658a1.googledrive.com/host/0B4kCH1jSvs-QTVZZQUJBWFZnZ3M'
fi
clear

if [ -e ~/Desktop/Kali/MultiROM.zip ]; then
echo ""
else
echo "Downloading MultiROM (6/10)"
echo ""
curl -o MultiROM.zip 'https://11377789dde55cdbe727b835190ac4ba464c0b54.googledrive.com/host/0B4kCH1jSvs-QVjRhREhwOEJoWTA'
fi
clear

if [ -e ~/Desktop/Kali/BaseKernel.zip ]; then
echo ""
else
if [[ "$kernel" == 'CM' || "$kernel" == 'cm' ]]; then
echo "Downloading modified kernel (CM) (7/10)"
echo ""
curl -o BaseKernel.zip 'https://f7ff7aa4a003db7fa84ece768efa244b345ea7db.googledrive.com/host/0B4kCH1jSvs-QenR6LUxNV2VPc2c'
elif [[ "$kernel" == 'AOSP' || "$kernel" == 'aosp' ]]; then
echo "Downloading modified kernel (AOSP) (7/10)"
echo ""
curl -o BaseKernel.zip 'https://1386c6afec610d0d42b9a7d0b7abe5ea002574c5.googledrive.com/host/0B4kCH1jSvs-QZDhKNkpJYndHUEk'
elif [[ "$kernel" == 'KEEP' || "$kernel" == 'Keep' || "$kernel" == 'keep' ]]; then
echo ""
fi
fi
clear;;

###########
##GROUPER##
###########

GROUPER|Grouper|grouper )

clear
echo ""
read -p "What is your current ROM based off of? (If in doubt, select AOSP) (CM/AOSP/Keep)" kernel
case "$kernel" in
esac
clear

if [ -e ~/Desktop/Kali/TWRP.img ]; then
echo ""
else
echo "Downloading TWRP recovery (3/10)"
echo ""
curl -o TWRP.img 'https://a0e0043c40ded627c45e16fa3fcbac32c710c462.googledrive.com/host/0B4kCH1jSvs-QclhHdXZ4U2lzLTQ'
fi
clear

if [ -e ~/Desktop/Kali/ROM.zip ]; then
echo ""
else
echo "Downloading OmniROM (4/10)"
echo ""
curl -o ROM.zip 'https://c989d9d00585c516416e2d55c99ad8d2faa27f5a.googledrive.com/host/0B4kCH1jSvs-QVW01eFYwZWplOE0'
fi
clear

if [ -e ~/Desktop/Kali/Kernel.zip ]; then
echo ""
else
echo "Downloading Kernel (5/10)"
echo ""
curl -o Kernel.zip 'https://4727ff79969b63d99112bb5c6f33b73e83251cf8.googledrive.com/host/0B4kCH1jSvs-QVGpObDFkSGN0VlU'
fi
clear

if [ -e ~/Desktop/Kali/MultiROM.zip ]; then
echo ""
else
echo "Downloading MultiROM (6/10)"
echo ""
curl -o MultiROM.zip 'https://fe099fe4fd57588989cfbd8f8cbe982780f45d2a.googledrive.com/host/0B4kCH1jSvs-QYUp4NHZMeG9NMWs'
fi
clear

if [ -e ~/Desktop/Kali/BaseKernel.zip ]; then
echo ""
else
if [[ "$kernel" == 'CM' || "$kernel" == 'cm' ]]; then
echo "Downloading modified kernel (CM) (7/10)"
echo ""
curl -o BaseKernel.zip 'https://da725fd3009572f2e674df55fc00e864914c4e54.googledrive.com/host/0B4kCH1jSvs-QU2t5MS1LckZLME0'
elif [[ "$kernel" == 'AOSP' || "$kernel" == 'aosp' ]]; then
echo "Downloading modified kernel (AOSP) (7/10)"
echo ""
curl -o BaseKernel.zip 'https://205cb8168f8c53f6b659a1eb922e3aa10fcf8fa5.googledrive.com/host/0B4kCH1jSvs-Qb2xtY0ppM1JjcFk'
elif [[ "$kernel" == 'KEEP' || "$kernel" == 'Keep' || "$kernel" == 'keep' ]]; then
echo ""
fi
fi
clear;;

###########
##TILAPIA##
###########

TILAPIA|Tilapia|tilapia )

clear
echo ""
read -p "What is your current ROM based off of? (If in doubt, select AOSP) (CM/AOSP/Keep)" kernel
case "$kernel" in
esac
clear

if [ -e ~/Desktop/Kali/TWRP.img ]; then
echo ""
else
echo "Downloading TWRP recovery (3/10)"
echo ""
curl -o TWRP.img 'https://cc0f127354545ebd0c322f928f937c914ab9572a.googledrive.com/host/0B4kCH1jSvs-QLUZXRGw3UmFHeWM'
fi
clear

if [ -e ~/Desktop/Kali/ROM.zip ]; then
echo ""
else
echo "Downloading OmniROM (4/10)"
echo ""
curl -o ROM.zip 'https://e72fa73ea9d8908e3c09080997f1668a619cba64.googledrive.com/host/0B4kCH1jSvs-QNVdSajdtYThjQ2s'
fi
clear

if [ -e ~/Desktop/Kali/Kernel.zip ]; then
echo ""
else
echo "Downloading Kernel (5/10)"
echo ""
curl -o Kernel.zip 'https://4727ff79969b63d99112bb5c6f33b73e83251cf8.googledrive.com/host/0B4kCH1jSvs-QVGpObDFkSGN0VlU'
fi
clear

if [ -e ~/Desktop/Kali/MultiROM.zip ]; then
echo ""
else
echo "Downloading MultiROM (6/10)"
echo ""
curl -o MultiROM.zip 'https://fe099fe4fd57588989cfbd8f8cbe982780f45d2a.googledrive.com/host/0B4kCH1jSvs-QYUp4NHZMeG9NMWs'
fi
clear

if [ -e ~/Desktop/Kali/BaseKernel.zip ]; then
echo ""
else
if [[ "$kernel" == 'CM' || "$kernel" == 'cm' ]]; then
echo "Downloading modified kernel (CM) (7/10)"
echo ""
curl -o BaseKernel.zip 'https://da725fd3009572f2e674df55fc00e864914c4e54.googledrive.com/host/0B4kCH1jSvs-QU2t5MS1LckZLME0'
elif [[ "$kernel" == 'AOSP' || "$kernel" == 'aosp' ]]; then
echo "Downloading modified kernel (AOSP) (7/10)"
echo ""
curl -o BaseKernel.zip 'https://205cb8168f8c53f6b659a1eb922e3aa10fcf8fa5.googledrive.com/host/0B4kCH1jSvs-Qb2xtY0ppM1JjcFk'
elif [[ "$kernel" == 'KEEP' || "$kernel" == 'Keep' || "$kernel" == 'keep' ]]; then
echo ""
fi
fi
clear;;

##############
##HAMMERHEAD##
##############

HAMMERHEAD|Hammerhead|hammerhead )

clear
echo ""
read -p "What is your current ROM based off of? (If in doubt, select AOSP) (CM/AOSP/Keep)" kernel
case "$kernel" in
esac
clear

if [ -e ~/Desktop/Kali/TWRP.img ]; then
echo ""
else
echo "Downloading TWRP recovery (3/10)"
echo ""
curl -o TWRP.img 'https://d2581b691cf0508481f99e24d819a60a9a4e76ab.googledrive.com/host/0B4kCH1jSvs-QVGVibWRpRzNEclk'
fi
clear

if [ -e ~/Desktop/Kali/ROM.zip ]; then
echo ""
else
echo "Downloading OmniROM (4/10)"
echo ""
curl -o ROM.zip 'https://a955d2b93439dfd6cf44a993014187e0043ec332.googledrive.com/host/0B4kCH1jSvs-QYUJDYUhreDdoU2M'
fi
clear

if [ -e ~/Desktop/Kali/Kernel.zip ]; then
echo ""
else
echo "Downloading Kernel (5/10)"
echo ""
curl -o Kernel.zip 'https://7150685e2695e874e86f7af50516057c8f1f65a0.googledrive.com/host/0B4kCH1jSvs-QbF9peGVnZkpxaWc'
fi
clear

if [ -e ~/Desktop/Kali/MultiROM.zip ]; then
echo ""
else
echo "Downloading MultiROM (6/10)"
echo ""
curl -o MultiROM.zip 'https://0975d5454125a1b92fbd39cb4543cc1d474e1429.googledrive.com/host/0B4kCH1jSvs-QeWpXb3k5LU44SlE'
fi
clear

if [ -e ~/Desktop/Kali/BaseKernel.zip ]; then
echo ""
else
if [[ "$kernel" == 'CM' || "$kernel" == 'cm' ]]; then
echo "Downloading modified kernel (CM) (7/10)"
echo ""
curl -o BaseKernel.zip 'https://16ca9e11ede561ea3a33f363ce79cbec29519769.googledrive.com/host/0B4kCH1jSvs-QX09rWlhWcG4tRUk'
elif [[ "$kernel" == 'AOSP' || "$kernel" == 'aosp' ]]; then
echo "Downloading modified kernel (AOSP) (7/10)"
echo ""
curl -o BaseKernel.zip 'https://b6e3c57ab255ea8be11083911c9a01d1c0916db0.googledrive.com/host/0B4kCH1jSvs-QNWJRRS16U2oyemc'
elif [[ "$kernel" == 'KEEP' || "$kernel" == 'Keep' || "$kernel" == 'keep' ]]; then
echo ""
fi
fi
clear;;

###########
##UNKNOWN##
###########

* )
echo "Unknown Choice. Exiting."
sleep 2
exit;;
esac
clear

#######
##ALL##
#######

if [ -e ~/Desktop/Kali/GApps.zip ]; then
echo ""
else
echo "Downloading GApps. (8/10)"
echo ""
curl -o GApps.zip 'https://5c2c32adaaf9940a8241b5118ad1189f700c1598.googledrive.com/host/0B4kCH1jSvs-QVng4aFg1eGh2elU'
fi
clear

if [ -e ~/Desktop/Kali/SU.zip ]; then
echo ""
else
echo "Downloading SuperSU. (9/10)"
echo ""
python << END
import urllib2
import urllib
 
class LatestRomUtil:
	
	def __init__(self, device):
		self.changeDevice(device)
	
	def __getPage(self, url, retRedirUrl = False):
		try:
			bOpener = urllib2.build_opener()
			bOpener.addheaders = [("User-agent", "Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/33.0.1750.146 Safari/537.36")]
			pResponse = bOpener.open(url)
			if retRedirUrl == True:
				return pResponse.geturl()
			else:
				pageData = pResponse.read()
				return pageData
		except Exception:
			return ""
		
	def changeDevice(self, device):
		self.device = device.strip().lower()
 
	def dlSuperSU(self):
		getUrl = self.__getPage("http://download.chainfire.eu/supersu", True)
		latestUrl = getUrl + "?retrieve_file=1"
		return latestUrl
		
	
# below is example usage
romUtil = LatestRomUtil("tf300t") # our device is tf300t in this example
 
print "Latest SuperSU: " + romUtil.dlSuperSU()
print "Downloading to LatestSuperSU.zip"
urllib.urlretrieve (romUtil.dlSuperSU(), "LatestSuperSU.zip")
END
fi
clear

if [ -e ~/Desktop/Kali/Utilities.zip ]; then
echo ""
else
echo "Downloading Kali Utilities. (10/10) (This could take a while!)"
echo ""
curl -o Utilities.zip 'https://33e44a405621e42b18580154364b86c6dc35122b.googledrive.com/host/0B4kCH1jSvs-QcUpYYlRPMFdEenM'
fi
clear

############
##FLASHING##
############

echo "All files have been downloaded. Please turn your tablet completely off and restart into the"
echo "bootloader by pressing and holding the volume down and power buttons at the same time."
echo ""
read -p "Press [Enter] to continue."
clear

echo "WARNING: IF YOUR BOOTLOADER IS LOCKED, YOU WILL LOSE YOUR DATA IN THIS NEXT STEP."
echo ""
read -p "Press [Enter] to continue."
clear

echo "Unlocking. (If not already unlocked)"
echo ""
echo "If prompted, please select Yes to erase all data and unlock the bootloader."
echo ""
./fastboot oem unlock
sleep 2
clear

echo "Flashing TWRP Recovery."
./fastboot flash recovery ~/Desktop/Kali/TWRP.img
./fastboot boot ~/Desktop/Kali/TWRP.img
sleep 20
./adb reboot recovery
clear

echo "Installing everything. Please wait. This could take a while."
mkdir ~/Desktop/Kali/cache

./adb push ~/Desktop/Kali/BaseKernel.zip /sdcard/kali/BaseKernel.zip
./adb push ~/Desktop/Kali/MultiROM.zip /sdcard/kali/MultiROM.zip
./adb shell "echo -e 'print ##################################\nprint #####Installing MultiROM#####\nprint ##################################\ninstall /sdcard/Kali/MultiROM.zip\nprint ###########################\nprint #####Installing Kernel#####\nprint ###########################\ninstall /sdcard/Kali/BaseKernel.zip\ncmd reboot recovery\n' > /cache/recovery/openrecoveryscript"











