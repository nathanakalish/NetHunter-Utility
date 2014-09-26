#!/bin/sh

printf '\033[8;27;100t'

###########################
###Device Selection Menu###
###########################
f_deviceselect(){
clear
echo "Kali Flash Utility v5.3"
echo ""
echo "Select your device:"
echo ""
echo "[1] Nexus  5  2013   Cellular  [Hammerhead]"
echo "[2] Nexus  7  2012   Wifi      [Grouper]"
echo "[3] Nexus  7  2012   Cellular  [Tilapia]"
echo "[4] Nexus  7  2013   Wifi      [Flo]"
echo "[5] Nexus  7  2013   LTE       [Deb]"
echo "[6] Nexus  10 2012   Wifi      [Manta]"
echo ""
echo "[Q] Exit"
echo ""
read -p "Please make a selection: " device

case $device in
	1) currentdevice="hammerhead"; currentmodel="Nexus 5"; clear; f_menu;;
	2) currentdevice="grouper"; currentmodel="Nexus 7"; clear; f_menu;;
	3) currentdevice="tilapia"; currentmodel="Nexus 7"; clear; f_menu;;
	4) currentdevice="flo"; currentmodel="Nexus 7"; clear; f_menu;;
	5) currentdevice="deb"; currentmodel="Nexus 7"; clear; f_menu;;
	6) currentdevice="manta"; currentmodel="Nexus 10"; clear; f_menu;;
	q) clear; exit;;
	*) clear; echo "Unknown selection, please try again"; f_deviceselect;;
esac
}

###############
###Main Menu###
###############
f_menu(){

maindir=~/Kali
commondir=~/Kali/All
devicedir=~/Kali/$currentdevice
mkdir -p $devicedir

echo "Kali Flash Utility v5.3"
echo ""
echo "Your current selected device is: $currentmodel $currentdevice"
echo ""
echo "Please make a selection:"
echo "[1] Install Everything                              [7] Download Files for manual install"
echo "[2] Install Everything (Multirom already Installed) [8] Delete All Existing Files"
echo "[3] Install Kali To Existing ROM                    [9] Select A Different Device"
echo "[4] Just Unlock Bootloader                          [10] Build Kali (Kali Linux Only)"
echo "[5] Just Install MultiROM                           [11] Update Script"
echo "[6] Remove MultiROM and Secondary ROMs"
echo ""
echo "[Q] Exit"
echo ""
read -p "Please make a selection: " menuselection

case $menuselection in
	1) f_dl_tools; f_dl_multirom; f_dl_kalirom; f_dl_gapps; f_dl_su; f_dl_kali; f_unlock; f_multirom; f_kalirom; f_rename; f_bth; f_gapps; f_bth; f_su; f_bth; f_kali; f_ reminders; f_menu;;
	2) f_dl_tools; f_dl_kalirom; f_dl_gapps; f_dl_su; f_dl_kali; f_btr; f_kalirom; f_bth; f_rename; f_bth; f_gapps; f_bth; f_su; f_bth; f_kali; f_ reminders; f_menu;;
	3) f_dl_tools; f_dl_su; f_dl_kali; f_unlock; f_menu;; 
	4) f_dl_tools; f_unlock; f_kalionly; f_menu;;
	5) f_dl_tools; f_dl_multirom; f_unlock; f_multirom; f_menu;;
	6) f_dl_twrp; f_dl_rmmultirom; f_rmmultirom; f_menu;;
	7) f_dl_tools; f_dl_multirom; f_dl_twrp; f_dl_rmmultirom; f_dl_kalirom; f_dl_gapps; f_dl_su; f_dl_kali; f_manual; f_menu;;
	8) f_delete;;
	9) f_deviceselect;;
	10) f_build; f_menu;;
	11) curl -L -o $BASH_SOURCE[0] 'https://raw.githubusercontent.com/photonicgeek/Kali-Flash-Utility/master/kfu.sh'; clear; echo "Please manually restart the script."; read -p "Press [Enter] to continue";;
	q) clear; exit;;
	*) f_menu;;
esac

}

########################
###Download ADB Tools###
########################
f_dl_tools(){
clear
unamestr=`uname`
if [[ "$unamestr" == 'Darwin' ]];
then
echo "OS X operating system detected."
echo ""
echo "Downloading ADB"
echo ""
curl -L -o ~/Kali/adb 'http://sourceforge.net/projects/kaliflashutility/files/Android%20Utilities/Mac/adb/download' --progress-bar
clear
echo "Downloading Fastboot"
echo ""
curl -L -o ~/Kali/fastboot 'http://sourceforge.net/projects/kaliflashutility/files/Android%20Utilities/Mac/fastboot/download' --progress-bar
else
echo "Linux-based OS detected."
echo ""
echo "Installing cURL (Password may be required)"
sudo apt-get -qq update && sudo apt-get -qq -y install curl
echo ""
echo "Downloading ADB"
echo ""
curl -L -o ~/Kali/adb 'http://sourceforge.net/projects/kaliflashutility/files/Android%20Utilities/Linux/adb/download' --progress-bar
clear
echo "Downloading Fastboot"
echo ""
curl -L -o ~/Kali/fastboot 'http://sourceforge.net/projects/kaliflashutility/files/Android%20Utilities/Linux/fastboot/download' --progress-bar
fi
adb=$maindir/adb
fastboot=$maindir/fastboot
chmod 755 $adb
chmod 755 $fastboot

clear
}

######################
###Run Build Script###
######################
f_build(){
echo "Making Directories"
mkdir ~/arm-stuff
cd ~/arm-stuff
echo "Cloning Git repositories to home directory"
git clone https://github.com/offensive-security/gcc-arm-linux-gnueabihf-4.7
export PATH=${PATH}:/root/arm-stuff/gcc-arm-linux-gnueabihf-4.7/bin
git clone https://github.com/binkybear/kali-scripts
cd ~/arm-stuff/kali-scripts
echo "Running Scripts"
./build-deps.sh
./androidmenu.sh
}

#######################
###Download MultiROM###
#######################
f_dl_multirom(){
clear
echo "Is your existing ROM based off of"
echo "[1] AOSP"
echo "[2] CyanogenMod"
echo ""
read -p "Make a selection: " basekernel
clear

echo "Downloading Multirom"
echo ""
url="http://sourceforge.net/projects/kaliflashutility/files/${currentdevice}/multirom.zip/download"
curl -L -o $devicedir/multirom.zip $url --progress-bar
clear

if [[ "$basekernel" == '1' ]];
	then
	kerneltype=""
elif [[ "$basekernel" == '2' ]];
	then
	kerneltype=-cm
fi

echo "Downloading MultiROM Kernel"
echo ""
url="http://sourceforge.net/projects/kaliflashutility/files/${currentdevice}/base-kernel${kerneltype}.zip/download"
curl -L -o $devicedir/base-kernel$kerneltype.zip $url --progress-bar
clear

echo "Downloading TWRP"
echo ""
url="http://sourceforge.net/projects/kaliflashutility/files/${currentdevice}/TWRP.img/download"
curl -L -o $devicedir/twrp.img $url --progress-bar
clear
}

##########################
###Download Normal TWRP###
##########################
f_dl_twrp(){
clear
url="http://techerrata.com/file/twrp2/$currentdevice/openrecovery-twrp-2.8.0.1-$currentdevice.img"
echo "Downloading Standard TWRP"
echo ""
curl -L -o $devicedir/stock-twrp.img $url --progress-bar
clear
}

###################################
###Download MultiROM Uninstaller###
###################################
f_dl_rmmultirom(){
clear
url="http://sourceforge.net/projects/kaliflashutility/files/$currentdevice/rm-multirom.zip/download"
echo "Downloading Standard TWRP"
echo ""
curl -L -o $devicedir/rm-multirom.img $url --progress-bar
clear
}

#######################
###Download Kali ROM###
#######################
f_dl_kalirom(){
clear

currentday=`date +%d`
ndays="1"
day=`expr $currentday - $ndays`
builddate=`date +%Y%m`"$day"

echo "What ROM would you like?"
echo "[1] OmniROM"
echo "[2] Paranoid Android"
echo "(More Coming Soon)"
echo ""
read -p "Make a selection: " romchoice

if [[ "$romchoice" == '1' ]];
	then
		rom=omnirom
		url="http://dl.omnirom.org/$currentdevice/omni-4.4.4-$builddate-$currentdevice-NIGHTLY.zip"
elif [[ "$romchoice" == '2' ]];
	then
		rom=paranoid
		url="http://download.paranoidandroid.co/roms/$currentdevice/pa_$currentdevice-4.6-BETA2-20140923.zip"
else
f_dl_kalirom
fi

clear
echo "Downloading ROM"
echo ""
curl -L -o $devicedir/$rom.zip $url --progress-bar
clear
}

####################
###Download GApps###
####################
f_dl_gapps(){
echo "What GApps package would you like?"
echo "[1] Pico GApps Package"
echo "[2] Nano GApps Package"
echo "[3] Micro GApps Package"
echo "[4] Mini GApps Package"
echo "[5] Full GApps Package"
echo "[6] Stock GApps Package"
echo ""

read -p "Make a selection: " gappschoice
if [[ "$gappschoice" == '1' ]];
	then
		gapps=pico
elif [[ "$gappschoice" == '2' ]];
	then
		gapps=nano
elif [[ "$gappschoice" == '3' ]];
	then
		gapps=micro
elif [[ "$gappschoice" == '4' ]];
	then
		gapps=mini
elif [[ "$gappschoice" == '5' ]];
	then
		gapps=full
elif [[ "$gappschoice" == '6' ]];
	then
		gapps=stock
else
f_dl_gapps
fi

clear
url="http://sourceforge.net/projects/kaliflashutility/files/All/$gapps-gapps.zip/download"
echo "Downloading ROM"
echo ""
curl -L -o $devicedir/$gapps-gapps.zip $url --progress-bar
clear
}

######################
###Download SuperSU###
######################
f_dl_su(){
clear
echo "Downloading SuperSU"
echo  ""
mkdir -p $commondir
cd $commondir
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
romUtil = LatestRomUtil("tf300t")
 
print "Downloading to su.zip"
urllib.urlretrieve (romUtil.dlSuperSU(), "su.zip")
END
cd ~/
echo "Download complete"
sleep 1
clear
}

#############################
###Download Kali Utilities###
#############################
f_dl_kali(){
clear
if [[ "$currentdevice" == 'flo' ]];
	then
	url="http://images.kali.org/kali_linux_nethunter_nexus7_2013.zip"
elif [[ "$currentdevice" == 'deb' ]];
	then
	url="http://images.kali.org/kali_linux_nethunter_nexus7_2013.zip"
elif [[ "$currentdevice" == 'grouper' ]];
	then
	url="http://images.kali.org/kali_linux_nethunter_nexus7_2012.zip"
elif [[ "$currentdevice" == 'tilapia' ]];
	then
	url="http://images.kali.org/kali_linux_nethunter_nexus7_2012.zip"
elif [[ "$currentdevice" == 'hammerhead' ]];
	then
	url="http://images.kali.org/kali_linux_nethunter_nexus5.zip"
elif [[ "$currentdevice" == 'manta' ]];
	then
	url="http://images.kali.org/kali_linux_nethunter_nexus10.zip"
fi
echo "Downloading Kali Utilities. (This could take a while!)"
echo ""
curl -L -o $devicedir/kali-utilities.zip $url --progress-bar
clear
}

###################
###Unlock Device###
###################
f_unlock(){
clear
echo "WARNING: This step will erase your device if your bootloader is locked!"
echo "If your bootloader is already unlocked, this will not affect your device."
echo ""
echo "Boot into the bootloader by turning off the device and holding the volume down and power button."
read -p "Press [Enter] to continue."
clear
echo "Unlocking"
echo ""
$fastboot oem unlock
sleep 2
clear
echo "On the screen there is a prompt to erase the device, select yes. THIS ERASES YOUR DEVICE!!!"
echo "Once the device finishes erasing, set up your device like normal before continuing"
echo "If your device is already unlocked the erase device screen won't show. Just continue."
echo ""
read -p "Press [Enter] to continue"
clear
}

###########################
###Kali Without MultiROM###
###########################
f_Kalionly(){
clear
echo "Your current ROM MUST BE based off of stock/AOSP. If it is not, you WILL have problems."
echo ""
read -p "Press [Enter] to continue"
clear
echo "Boot into the bootloader by turning off the device and holding the volume down and power button."
echo ""
read -p "Press [Enter] to continue."
clear
echo "Please wait. Your device will reboot a few times. Dont touch your device until told to do so."
echo ""
echo "Flashing TWRP"
$fastboot flash recovery $devicedir/stock-twrp.img
clear
echo "Please wait. Your device will reboot a few times. Don't touch your device until told to do so."
echo ""
echo "Booting into recovery"
$fastboot boot $devicedir/stock-twrp.img
sleep 30
clear
echo "Please wait. Your device will reboot a few times. Don't touch your device until told to do so."
echo ""
echo "Booting into recovery (again)"
$adb reboot recovery
sleep 30
clear
echo "Please wait. Your device will reboot a few times. Don't touch your device until told to do so."
echo ""
echo "Moving files to device to install"
$adb push $commondirdir/su.zip /sdcard/kali/su.zip
$adb push $devicedir/kali-utilities.zip /sdcard/kali/kali-utilities.zip
$adb shell "echo -e 'print ############################\nprint #####Installing SuperSU#####\nprint ############################\ninstall /sdcard/kali/su.zip\nprint #########################\nprint #####Installing Kali#####\nprint #########################\ninstall /sdcard/kali/kali-utilities.zip\ncmd reboot recovery\n' > /cache/recovery/openrecoveryscript"
$adb reboot recovery
read -p "Press [Enter] when flashing is copmplete and booted back into recovery homescreen."
$adb shell rm -rf /sdcard/kali/kali-utilities.zip
$adb shell rm -rf /sdcard/kali/su.zip
$adb reboot
clear
}

####################
###Flash MultiROM###
####################
f_multirom(){
clear
echo "Boot into the bootloader by turning off the device and holding the volume down and power button."
echo ""
read -p "Press [Enter] to continue."
clear
echo "Please wait. Your device will reboot a few times. Dont touch your device until told to do so."
echo ""
echo "Flashing TWRP"
$fastboot flash recovery $devicedir/twrp.img
clear
echo "Please wait. Your device will reboot a few times. Don't touch your device until told to do so."
echo ""
echo "Booting into recovery"
$fastboot boot $devicedir/twrp.img
sleep 30
clear
echo "Please wait. Your device will reboot a few times. Don't touch your device until told to do so."
echo ""
echo "Booting into recovery (again)"
$adb reboot recovery
sleep 30
clear
echo "Please wait. Your device will reboot a few times. Don't touch your device until told to do so."
echo ""
echo "Moving files to device to install"
$adb push $devicedir/base-kernel${kerneltype}.zip /sdcard/kali/base-kernel.zip
$adb push $devicedir/multirom.zip /sdcard/kali/multirom.zip
$adb shell "echo -e 'print #############################\nprint #####Installing MultiROM#####\nprint #############################\ninstall /sdcard/kali/multirom.zip\nprint ###########################\nprint #####Installing Kernel#####\nprint ###########################\ninstall /sdcard/kali/base-kernel.zip\ncmd reboot recovery\n' > /cache/recovery/openrecoveryscript"
$adb reboot recovery
sleep 90
$adb shell rm -rf /sdcard/kali/base-kernel.zip
$adb shell rm -rf /sdcard/kali/multirom.zip
$adb reboot recovery
clear
}

######################
###Boot To Recovery###
######################
f_btr(){
clear
echo "Boot into recovery by turning the device off and pressing and holding volume up and power."
echo "If you are already in recovery, make sure you are at the home screen."
echo ""
read -p "Press [Enter] to continue."
clear
}


##################
###Back to Home###
##################
f_bth(){
clear
echo "Press the home buttom at the bottom left of the screen"
echo ""
read -p "Press [Enter] to continue."
clear
}

####################
###Flash Kali ROM###
####################
f_kalirom(){
clear
echo "Tap Advanced > MultiROM > Add ROM > Next > ADB Sideload"
echo ""
read -p "Press [Enter] to continue."
clear
echo "Flashing ROM"
echo ""
$adb sideload $devicedir/$rom.zip
echo ""
read -p "Press [Enter] when flashing is complete."
clear
}

################
###Rename ROM###
################
f_rename(){
clear
echo "Tap Advanced > MultiROM > List ROMs > Sideload > Rename > Rename it to Kali,"
echo "then return to the home screen by pressing the home button at the bottom left."
echo ""
read -p "Press [Enter] to continue."
clear
}

###################
###Install GApps###
###################
f_gapps(){
clear
echo "Tap Advanced > MultiROM > List ROMs > Kali > Sideload"
echo ""
read -p "Press [Enter] to continue"
clear
echo "Flashing GApps"
echo ""
$adb sideload $commondir/$gapps-gapps.zip
echo ""
read -p "Press [Enter] when flashing is complete"
clear
}

#####################
###Install SuperSU###
#####################
f_su(){
clear
echo "Tap Advanced > MultiROM > List ROMs > Kali > Sideload"
echo ""
read -p "Press [Enter] to continue"
clear
echo "Flashing SuperSU"
echo ""
$adb sideload $commondir/su.zip
echo ""
read -p "Press [Enter] when flashing is complete"
clear
}

##########################
###Flash Kali Utilities###
##########################
f_kali(){
clear
echo "Tap Advanced > MultiROM > List ROMs > Kali > Sideload"
echo ""
read -p "Press [Enter] to continue"
clear
echo "Flashing Kali utilities (This could take a while!)"
echo ""
$adb sideload $devicedir/kali-utilities.zip
echo ""
read -p "Press [Enter] when flashing is complete"
clear
}

#####################
###Remove MultiROM###
#####################
f_rmmultirom(){
clear
echo "Boot into the bootloader by turning off the device and holding the volume down and power button."
echo ""
read -p "Press [Enter] to continue."
clear
echo "Please wait. Your device will reboot a few times. Dont touch your device until told to do so."
echo ""
echo "Flashing Normal TWRP"
$fastboot flash recovery $devicedir/stock-twrp.img
clear
echo "Please wait. Your device will reboot a few times. Don't touch your device until told to do so."
echo ""
echo "Booting into recovery"
$fastboot boot $devicedir/stock-twrp.img
sleep 30
clear
echo "Please wait. Your device will reboot a few times. Don't touch your device until told to do so."
echo ""
echo "Booting into recovery (again)"
$adb reboot recovery
sleep 30
clear
echo "Please wait. Your device will reboot a few times. Don't touch your device until told to do so."
echo ""
echo "Moving files to device to install"
$adb push $devicedir/rm-multirom.zip /sdcard/kali/rm-multirom.zip
$adb shell "echo -e 'print ###########################\nprint #####Removing MultiROM#####\nprint ###########################\ninstall /sdcard/kali/rm-multirom.zip\ncmd reboot recovery\n' > /cache/recovery/openrecoveryscript"
$adb reboot recovery
read -p "Press [Enter] when complete"
$adb shell rm -rf /sdcard/kali/rm-multirom.zip
$adb reboot recovery
clear
}

#################################
###Manual Install Instructions###
#################################
f_manual(){
clear
echo "All files have been downloaded."
echo "To manually install the files, install them in this order:"
echo "1. Flash TWRP.img"
echo "2. Flash Multirom.zip"
echo "3. Flash base-kernel.zip or base-kernel-cm.zip"
echo "4. Flash omni.zip or paranoid.zip as a new ROM"
echo "5. Flash gapps.zip to the new ROM"
echo "6. Flash su.zip to the new ROM"
echo "7. Flash kali-utilities.zip to the new ROM"
echo "8. You're done!"
echo "If any of this doesn't make sense, use the 'Install Everything' selection in the main menu"
echo ""
read -p "Press [Enter] to continue"
clear
}

###############
###Reminders###
###############
f_reminders(){
clear
echo "REMINDER:"
echo ""
echo "If you update your Stock ROM, re-flash base-kernel.zip"
echo "If you update your Kali NetHunter ROM, you ned to flash: kali-utilities.zip"
read -p "Press [Enter] to continue"
clear
}

######################
###Delete all files###
######################
f_delete(){
clear
read -p "Are you want to delete all of the files? (Y/N) " del
case $del in
Y|y ) 
clear
echo "Deleting files..."
rm -rf $maindir
sleep 2
clear
echo "Deleted"
sleep 2
clear
f_deviceselect;;
N|n )
clear
echo "Keeping files..."
sleep 2
clear
f_menu;;
esac
}

f_deviceselect