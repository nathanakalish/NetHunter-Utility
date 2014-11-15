#!/bin/sh
printf '\033[8;27;100t'

###########################
###Device Selection Menu###
###########################
f_deviceselect(){
clear
echo "Kali Flash Utility v1.9 beta"
echo "Select your device:"
echo ""
echo "[1]  Nexus 4  2012  Phone       [Mako] [EXPERIMENTAL]"
echo "[2]  Nexus 5  2013  Phone       [Hammerhead]"
echo "[3]  Nexus 6  2014  Phone       [Shamu] [Not Supported Yet]"
echo ""
echo "[4]  Nexus 7  2012  Wifi Only   [Grouper]"
echo "[5]  Nexus 7  2012  Cellular    [Tilapia]"
echo "[6]  Nexus 7  2013  Wifi Only   [Flo]"
echo "[7]  Nexus 7  2013  LTE         [Deb]"
echo ""
echo "[8]  Nexus 9  2014  Wifi Only   [Flounder] [Not Supported Yet]"
echo "[9]  Nexus 9  2014  LTE         [Unknown] [Not Supported Yet]"
echo "[10] Nexus 10 2012  Wifi Only   [Manta]"
echo ""
echo "[11] Other Unsupported Device [Use at your own risk. Make a backup]"
echo ""
echo "[12] Other Options"
echo ""
echo "[Q] Exit"
echo ""
read -p "Please make a selection: " device

case $device in
	1) currentdevice="mako"; currentmodel="Nexus 4 2012"; f_experimentalsupport; f_mkdir; f_menu;;
	2) currentdevice="hammerhead"; currentmodel="Nexus 5 2013"; f_mkdir; f_menu;;
	### Don't Use this one yet.
	33333) currentdevice="shamu"; currentmodel="Nexus 6 2014"; f_mkdir; f_menu;;
	3) f_notyetsupported;;

	4) currentdevice="grouper"; currentmodel="Nexus 7 2012 Wifi"; f_mkdir; f_menu;;
	5) currentdevice="tilapia"; currentmodel="Nexus 7 2012 Cellular"; f_mkdir; f_menu;;
	6) currentdevice="flo"; currentmodel="Nexus 7 2013 Wifi"; f_mkdir; f_menu;;
	7) currentdevice="deb"; currentmodel="Nexus 7 2013 LTE"; f_mkdir; f_menu;;

	### Or this one.
	88888) currentdevice="flounder"; currentmodel="Nexus 9 2014 Wifi"; f_mkdir; f_menu;;
	8) f_notyetsupported;;
	### Or this one. They are very broken options right now.
	99999) currentdevice="Unknown"; currentmodel="Nexus 9 2014 LTE"; f_mkdir; f_menu;;
	9) f_notyetsupported;;
	10) currentdevice="manta"; currentmodel="Nexus 10 Wifi"; f_mkdir; f_menu;;

	11) clear; read -p "What do you want the device to be referred to as?" currentdevice; currentmodel="Custom Device"; f_mkdir; f_custommenu; clear;;

	12) f_options;;

	q) clear; exit;;
	*) f_deviceselect;;
esac
}

f_notyetsupported(){
	clear
	echo "This device is not supported yet due to the lack of components to make it work. Try again later."
	echo ""
	read -p "Press [Enter] to continue" null
	f_deviceselect
}

f_experimentalsupport(){
	clear
	echo "SUPPORT FOR THIS DEVICE IS EXPERIMENTAL. USE AT YOUR OWN RISK."
	echo ""
	read -p "Press [Enter] to continue" null
}

######################
###Make Directories###
######################
f_mkdir(){
maindir=~/Kali
commondir=$maindir/All
devicedir=$maindir/$currentdevice
apkdir=$maindir/APKs
mkdir -p $commondir
mkdir -p $apkdir
mkdir -p $devicedir
}

f_options(){
	clear
	echo "NetHunter Installer Options"
	echo ""
	echo "[1] Delete existing downloaded files"
	echo "[2] Build NetHunter from source (Kali based OS ONLY)"
	echo "[3] Update NetHunter installer"
	echo ""
	echo "[Q] Return to device select menu"
	read -p "Please make a selection: " selection

case $selection in
	1) f_delete; f_deviceselect;;
	2) f_build; f_menu;;
	3) f_update;;
	q) f_deviceselect;;
esac
}

###############
###Main Menu###
###############
f_menu(){

clear
echo "NetHunter Utility v1.9 beta"
echo "Current Device: $currentmodel ($currentdevice)"
echo ""
echo "Please make a selection:"
echo "[1] Install NetHunter"
echo "[2] Unlock Bootloader"
echo "[3] Install MultiROM"
echo "[4] Remove MultiROM and Secondary ROMs"
echo "[5] Install Additional Tools"
echo "[6] Erase device and restore to stock"
echo ""
echo "[D] Select A Different Device"
echo ""
echo "[Q] Exit"
echo ""
read -p "Please make a selection: " menuselection

case $menuselection in
	1) f_nethuntermenu;;
	2) f_dl_tools; f_unlock; f_menu;;
	3) f_dl_tools; f_dl_multirom; f_unlock; f_multirom; f_menu;;
	4) f_dl_twrp; f_dl_rmmultirom; f_rmmultirom; f_menu;;
	5) f_dl_tools; f_kalitools;;
	6) f_restore; f_menu;;
	d) f_deviceselect;;
	q) clear; exit;;
	lpv) f_lpreview; f_menu;;
	*) f_menu;;
esac
}

#############################
###Custom Device Main Menu###
#############################
f_custommenu(){

customdevice=1

clear
echo "Kali Flash Utility v1.6.2"
echo "Current Device: $currentmodel ($currentdevice)"
echo "Your device MUST have TWRP recovery installed in order to continue"
echo ""
echo "Please make a selection:"
echo "[1] Install Kali NetHunter"
echo "[2] Install Additional Tools"
echo ""
echo "[D] Select A Different Device"
echo ""
echo "[Q] Exit"
echo ""
read -p "Please make a selection: " menuselection

case $menuselection in
	1) f_dl_tools; f_dl_su; f_dl_kali; f_kalinotwrp; f_menu;;
	2) f_dl_tools; f_kalitools;;
	d) f_deviceselect;;
	q) clear; exit;;
	*) f_menu;;
esac
}

####################
###NetHunter Menu###
####################
f_nethuntermenu(){
clear
echo "Nethunter Menu"
echo ""
echo "[1] Install NetHunter and MultiROM"
echo "[2] Install NetHunter with MultiROM Already Installed"
echo "[3] Install Nethunter to Existing ROM"
echo "[4] Download Files for manual install"
echo ""
echo "[Q] Return to Device Menu"
echo ""
read -p "Please make a selection: " nhselect

case $nhselect in
	1) nmr=0; f_questions; f_dl_tools; f_dl_multirom; f_dl_kalirom; f_dl_gapps; f_dl_su; f_dl_kali; f_unlock; f_multirom; f_kali; f_menu;;
	2) nmr=1; f_questions; f_dl_tools; f_dl_kalirom; f_dl_gapps; f_dl_su; f_dl_kali; f_kali; f_menu;;
	3) f_dl_tools; f_dl_su; f_dl_kali; f_unlock; f_kalionly; f_menu;;
	4) f_questions; f_dl_tools; f_dl_multirom; f_dl_twrp; f_dl_rmmultirom; f_dl_kalirom; f_dl_gapps; f_dl_su; f_dl_kali; f_menu;;
	q) f_menu;;
	*) f_nethuntermenu;;
esac
}

#######################
###Installable Tools###
#######################
f_kalitools(){
clear
echo "Kali Tools (ADB Debugging must be enabled, and device must be plugged in!)"
echo ""
echo "[1] Install dSploit"
echo "[2] Install Zimperium ANTI"
echo "[3] Install Network Spoofer"
echo "[4] Install USB Keyboard"
echo "[5] Install DriveDroid"
echo "[6] Install MultiROM Manager"
echo "[7] Install ADB and Fastboot tools for Kali"
echo ""
echo "[Q] Return to main menu"
echo ""
read -p "Make a selection: " ktools
clear

case $ktools in
1)
	echo "Downloading dSploit"
	echo ""
	curl -o $apkdir/dsploit.apk 'http://rootbitch.cc/dsploit/dSploit-nightly.apk' --progress-bar
	clear
	echo "Waiting for device"
	$adb wait-for-device
	clear
	echo "Installing dSploit. There may be additional confirmation dialogs on your device."
	echo ""
	$adb install $apkdir/dsploit.apk;;
2)
	echo "Downloading Zimperium ANTI"
	echo ""
	curl -o $apkdir/zanti.apk 'https://s3.amazonaws.com/zANTI/zANTI2.apk' --progress-bar
	clear
	echo "Waiting for device"
	$adb wait-for-device
	clear
	echo "Installing Zimperium ANTI. There may be additional confirmation dialogs on your device."
	echo ""
	$adb install $apkdir/zanti.apk;;
3)
	echo "Downloading Network Spoofer"
	echo ""
	curl -L -o $apkdir/netspoof.apk 'http://sourceforge.net/projects/netspoof/files/netspoof/android-netspoof-2.0.2.apk/download' --progress-bar
	clear
	echo "Waiting for device"
	$adb wait-for-device
	clear
	echo "Installing Network Spoofer. There may be additional confirmation dialogs on your device."
	echo ""
	$adb install $apkdir/netspoof.apk;;
4)
	echo "Downloading USB Keyboard"
	echo ""
	curl -o $apkdir/usbkeyboard.apk 'https://raw.githubusercontent.com/pelya/android-keyboard-gadget/master/USB-Keyboard.apk' --progress-bar
	clear
	echo "Waiting for device"
	$adb wait-for-device
	clear
	echo "Installing USB Keyboard. There may be additional confirmation dialogs on your device."
	echo ""
	$adb install $apkdir/usbkeyboard.apk;;
5)
	echo "Downloading DriveDroid"
	echo ""
	curl -o $apkdir/drivedroid.apk 'http://softwarebakery.com/apps/drivedroid/files/drivedroid-free-0.9.17.apk' --progress-bar
	clear
	echo "Waiting for device"
	$adb wait-for-device
	clear
	echo "Installing DriveDroid. There may be additional confirmation dialogs on your device."
	echo ""
	$adb install $apkdir/drivedroid.apk;;
6)
	echo "Downloading MultiROM Manager"
	echo ""
	curl -L -o $apkdir/multirommgr.apk 'http://sourceforge.net/projects/kaliflashutility/files/All/multirommgr.apk/download' --progress-bar
	clear
	echo "Waiting for device"
	$adb wait-for-device
	clear
	echo "Installing MultiROM Manager. There may be additional confirmation dialogs on your device."
	echo ""
	$adb install $apkdir/multirommgr.apk;;
q)
	clear; f_menu;;
esac
clear
echo "Done!"
sleep 2
f_kalitools
}

########################
###Download ADB Tools###
########################
f_dl_tools(){
clear
unamestr=`uname`
cd $maindir
case $unamestr in
Darwin)
	echo "OS X operating system detected."
	echo ""
	echo "Downloading ADB and Fastboot (Developer Tools required)"
	echo ""
	cd $commondir
	git clone git://git.kali.org/packages/google-nexus-tools
	clear
	echo "Setting Up Tools"
	mv ./google-nexus-tools ./adb-tools
	cd ./adb-tools
	mv ./bin/* ./
	rm -rf ./bin
	rm -rf ./debian
	rm -rf install.sh
	rm -rf license.txt
	rm -rf README.md
	rm -rf udev.txt
	rm -rf uninstall.sh
	cd ~/
	adb=$commondir/adb-tools/mac-adb
	fastboot=$commondir/adb-tools/mac-fastboot;;
*)
	echo "Linux-based OS detected."
	echo ""
	echo "Installing cURL (Password may be required)"
	echo ""
	sudo apt-get -qq update && sudo apt-get -qq -y install curl
	clear
	echo "Downloading ADB and Fastboot"
	echo ""
	cd $commondir
	git clone git://git.kali.org/packages/google-nexus-tools
	clear
	echo "Setting Up Tools"
	gunzip -c adbtools.tar.gz | tar xopf -
	mv ./google-nexus-tools ./adb-tools
	cd ./adb-tools
	mv ./bin/* ./
	rm -rf ./bin
	rm -rf ./debian
	rm -rf install.sh
	rm -rf license.txt
	rm -rf README.md
	rm -rf udev.txt
	rm -rf uninstall.sh
	cd ~/
	adb=$commondir/adb-tools/linux-i386-adb
	fastboot=$commondir/adb-tools/linux-i386-fastboot;;
esac

cd ~/
chmod 755 $adb
chmod 755 $fastboot
clear
}

######################
###Run Build Script###
######################
f_build(){
unamestr=`uname`
case $unamestr in
Darwin)
	clear
	echo "Sorry, OS X is not supported!"
	echo ""
	read -p "Press [Enter] to return to the main menu" null
	clear;;
*)
	unamearch=`uname -m`
	case $unamearch in
		x86_64|amd64)
			clear
			if [ -d ~/arm-stuff/kali-nethunter ]; then
  			clear
			else
				echo "Making Directories"
				mkdir ~/arm-stuff
				cd ~/arm-stuff
				echo "Cloning Git repositories to home directory"
				git clone https://github.com/offensive-security/gcc-arm-linux-gnueabihf-4.7
				export PATH=${PATH}:/root/arm-stuff/gcc-arm-linux-gnueabihf-4.7/bin
				git clone https://github.com/offensive-security/kali-nethunter
				cd ~/arm-stuff/kali-nethunter
				echo "Running Scripts"
				./build-deps.sh
			fi
			clear
			echo "Build Options:"
			echo ""
			echo "[1] Build NetHunter Package"
			echo "[2] Build Kernel"
			echo ""
			echo "[Q] Return to options menu"
			echo ""
			read -p "Please make a selection" selection

			case $selection in
				1)
					cd ~/arm-stuff/kali-nethunter
					./androidmenu.sh rootfs ~/Kali/Builds/NetHunter
					clear
					echo "Your new file can be found in ~/Kali/Builds/NetHunter organized by device or type."
					echo ""
					read -p "Press [Enter] to return to the options menu";;
				2)
					clear
					echo "Select a device to build for:"
					echo ""
					echo "[1]  Nexus 4  2012  Phone       [Mako] [EXPERIMENTAL]"
					echo "[2]  Nexus 5  2013  Phone       [Hammerhead]"
					echo "[3]  Nexus 6  2014  Phone       [Shamu] [Not Supported Yet]"
					echo ""
					echo "[4]  Nexus 7  2012  Wifi Only   [Grouper]"
					echo "[5]  Nexus 7  2012  Cellular    [Tilapia]"
					echo "[6]  Nexus 7  2013  Wifi Only   [Flo]"
					echo "[7]  Nexus 7  2013  LTE         [Deb]"
					echo ""
					echo "[8]  Nexus 9  2014  Wifi Only   [Flounder] [Not Supported Yet]"
					echo "[9]  Nexus 9  2014  LTE         [Unknown] [Not Supported Yet]"
					echo "[10] Nexus 10 2012  Wifi Only   [Manta]"
					echo ""
					echo "[Q] Return to options menu"
					echo ""
					read -p "Please make a selection: " selection

					case $selection in
						1) device="mako";;
						2) device="hammerhead";;
						3) device="shamu";;
						4) device="grouper";;
						5) device="tilapia";;
						6) device="flo";;
						7) device="deb";;
						8) device="flounder";;
						9) device="unknown";;
						10) device="manta";;
					esac

					cd ~/arm-stuff/kali-nethunter
					./androidmenu.sh kernel $device ~/Kali/Builds/NetHunter
					clear
					echo "Your new file can be found in ~/Kali/Builds/NetHunter organized by device or type.";;
			esac
			clear;;
		*)
			echo "Sorry, only 64 Bit installations of linux are supported!"
			echo "If you believe this is an error, please report it to photonicgeek"
			echo ""
			read -p "Press [Enter] to return to the main menu" null
			clear;;
	esac
	clear;;

esac
}


###############
###Questions###
###############
f_questions(){
case $nmr in
1) clear;;
*)
	clear
	echo "Is your existing ROM based off of"
	echo "[1] AOSP"
	echo "[2] CyanogenMod"
	echo ""
	read -p "Make a selection: " basekernel

	clear
	if [ -e $devicedir/multirom.zip ]; then
	echo "MultiROM found:"
	echo "[1] Delete and Redownload"
	echo "[2] Reuse"
	echo ""
	read -p "Make a Selection: " keepmultirom
	case $keepmultirom in
		1) clear; echo "Deleting..."; rm -rf $devicedir/multirom.zip; keepmultirom=0;;
		2) clear; echo "Keeping file"; keepmultirom=1;;
	esac
	fi

	clear
	if [ -e $devicedir/base-kernel.zip ]||[ -e; then
	echo "Base Kernel found:"
	echo "[1] Delete and Redownload"
	echo "[2] Reuse"
	echo ""
	read -p "Make a Selection: " keepbasekernel
	case $keepbasekernel in
		1) clear; echo "Deleting..."; rm -rf $devicedir/base-kernel.zip; rm -rf $devicedir/base-kernel-cm.zip; keepbasekernel=0;;
		2) clear; echo "Keeping file"; keepbasekernel=1;;
	esac
	fi

	clear
	if [ -e $devicedir/TWRP.img ]; then
	echo "TWRP found:"
	echo "[1] Delete and Redownload"
	echo "[2] Reuse"
	echo ""
	read -p "Make a Selection: " keeptwrp
	case $keeptwrp in
		1) clear; echo "Deleting..."; rm -rf $devicedir/TWRP.img; keeptwrp=0;;
		2) clear; echo "Keeping file"; keeptwrp=1;;
	esac
	fi;;
esac

clear
echo "What ROM would you like?"
echo "[1] OmniROM"
echo "[2] Paranoid Android"
echo ""
echo "[3] Custom (Must be AOSP based)"
if [ -e $devicedir/omnirom.zip ]||[ -e $devicedir/paranoid.zip ]; then
echo ""
echo "[4] Existing Download"
fi
echo ""
read -p "Make a selection: " romchoice

case $romchoice in
	3)
		clear
		echo "Please drag your desired ROM into this window, then press [Enter], or [Q] to go back."
		echo ""
		read -p "" customrom
		case $customrom in
			q) f_allquestions;;
			*) cp $customrom $devicedir/customrom.zip;;
		esac;;
	4)
		clear
		echo "Finding existing ROMs"
		sleep 1
		clear
		echo "ROMs Found"

		if [ -e $devicedir/omnirom.zip ]; then
		echo "[O]mniROM"
		fi
		if [ -e $devicedir/paranoid.zip ]; then
		echo "[P]aranoid Android"
		fi
		echo ""
		echo "[Q] Go back"
		echo ""
		read -p "Make a Selection: " romselection

		case $romselection in
			o) reuserom=1; rom=omnirom;;
			p) reuserom=1; rom=paranoid;;
			q) f_allquestions;;
		esac;;
esac

clear
echo "What GApps package would you like?"
echo "[1] Pico GApps Package"
echo "[2] Nano GApps Package"
echo "[3] Micro GApps Package"
echo "[4] Full GApps Package"
echo "[5] Stock GApps Package"
if [ -e $commondir/pico-gapps.zip ]||[ -e $commondir/nano-gapps.zip ]||[ -e $commondir/micro-gapps.zip ]||[ -e $commondir/full-gapps.zip ]||[ -e $commondir/stock-gapps.zip ]; then
echo ""
echo "[6] Exsisting Download"
fi
echo ""
read -p "Make a selection: " gappschoice

case $gappschoice in
	6)
	clear
	echo "Finding existing GApps Packages"
	sleep 1
	clear
	echo "GApps Packages Found:"

	if [ -e $commondir/pico-gapps.zip ]; then
	echo "[P]ico GApps"
	fi
	if [ -e $commondir/nano-gapps.zip ]; then
	echo "[N]ano GApps"
	fi
	if [ -e $commondir/micro-gapps.zip ]; then
	echo "[M]icro GApps"
	fi
	if [ -e $commondir/full-gapps.zip ]; then
	echo "[F]ull GApps"
	fi
	if [ -e $commondir/stock-gapps.zip ]; then
	echo "[S]tock GApps"
	fi
	echo ""
	echo "[Q] Go back"
	echo ""
	read -p "Make a Selection: " gappsselection

	case $gappsselection in
		p) reusegapps=1; gapps=pico;;
		n) reusegapps=1; gapps=nano;;
		m) reusegapps=1; gapps=micro;;
		f) reusegapps=1; gapps=full;;
		s) reusegapps=1; gapps=stock;;
		q) f_allquestions;;
	esac;;
esac

clear
if [ -e $commondir/su.zip ]; then
echo "SuperSU found:"
echo "[1] Delete and Redownload"
echo "[2] Reuse"
echo ""
read -p "Make a Selection: " keepsu
case $keepsu in
	1) clear; echo "Deleting..."; rm -rf $commondir/su.zip; keepsu=0;;
	2) clear; echo "Keeping file"; keepsu=1;;
esac
fi

clear
if [ -e $devicedir/kali-utilities.zip ]; then
echo "Kali NetHunter Package found:"
echo "[1] Delete and Redownload"
echo "[2] Reuse"
echo ""
read -p "Make a Selection: " keepkali
case $keepkali in
	1) clear; echo "Deleting..."; rm -rf $devicedir/kali-utilities.zip; keepkali=0;;
	2) clear; echo "Keeping file"; keepkali=1;;
esac
fi
clear
}

#######################
###Download MultiROM###
#######################
f_dl_multirom(){
clear
case $basekernel in
	1) kerneltype="";;
	2) kerneltype=-cm;;
esac

case $keepmultirom in
1) echo "Using Existing MultiROM"; sleep 1;;
*)
echo "Downloading Multirom"
echo ""
url="http://sourceforge.net/projects/kaliflashutility/files/${currentdevice}/multirom.zip/download"
curl -L -o $devicedir/multirom.zip $url --progress-bar;;
esac
clear


case $keepbasekernel in
1) echo "Using Existing MultiROM Kernel"; sleep 1;;
*)
echo "Downloading MultiROM Kernel"
echo ""
url="http://sourceforge.net/projects/kaliflashutility/files/${currentdevice}/base-kernel${kerneltype}.zip/download"
curl -L -o $devicedir/base-kernel$kerneltype.zip $url --progress-bar;;
esac
clear

case $keeptwrp in
1) echo "Using Existing TWRP Recovery"; sleep 1;;
*)
echo "Downloading TWRP"
echo ""
url="http://sourceforge.net/projects/kaliflashutility/files/${currentdevice}/TWRP.img/download"
curl -L -o $devicedir/twrp.img $url --progress-bar;;
esac
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
curl -L -o $devicedir/rm-multirom.zip $url --progress-bar
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

case $reuserom in
	1)
	echo "Using Existing ROM"
	sleep 1;;
	*)
	case $romchoice in
		1)
		rom=omnirom
		url="http://dl.omnirom.org/$currentdevice/omni-4.4.4-$builddate-$currentdevice-NIGHTLY.zip"
		clear
		echo "Downloading ROM"
		echo ""
		curl -L -o $devicedir/$rom.zip $url --progress-bar
		clear;;
		2)
		rom=paranoid
		url="http://download.paranoidandroid.co/roms/$currentdevice/pa_$currentdevice-4.6-BETA5-20141021.zip"
		clear
		echo "Downloading ROM"
		echo ""
		curl -L -o $devicedir/$rom.zip $url --progress-bar
		clear;;
		3)
		rom=customrom
		clear
		echo "Using Custom ROM"
		sleep 2
		clear;;
		*) f_dl_kalirom;;
	esac;;
esac
}

####################
###Download GApps###
####################
f_dl_gapps(){
clear
case $gappschoice in
	1) gapps=pico;;
	2) gapps=nano;;
	3) gapps=micro;;
	4) gapps=full;;
	5) gapps=stock;;
	6) clear;;
	*) f_dl_gapps;;
esac

case $reusegapps in
	1) echo "Using Existing GApps"; sleep 1;;
	*)
	clear
	url="http://sourceforge.net/projects/kaliflashutility/files/All/$gapps-gapps.zip/download"
	echo "Downloading GApps"
	echo ""
	curl -L -o $commondir/$gapps-gapps.zip $url --progress-bar
	clear
esac
clear
}

######################
###Download SuperSU###
######################
f_dl_su(){
clear
case $keepsu in
1) echo "Using Existing SuperSU"; sleep 1;;
*)
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
sleep 1;;
esac
clear
}

#############################
###Download Kali Utilities###
#############################
f_dl_kali(){
clear

case $keepkali in
	1) echo "Using Existing Kali Package"; sleep 1;;
	*)
		case $currentdevice in
			flo) url="http://images.kali.org/kali_linux_nethunter_nexus7_2013.zip";;
			deb) url="http://images.kali.org/kali_linux_nethunter_nexus7_2013.zip";;
			grouper) url="http://images.kali.org/kali_linux_nethunter_nexus7_2012.zip";;
			tilapia) url="http://images.kali.org/kali_linux_nethunter_nexus7_2012.zip";;
			hammerhead) url="http://images.kali.org/kali_linux_nethunter_nexus5.zip";;
			manta) url="http://images.kali.org/kali_linux_nethunter_nexus10.zip";;
			mako) url="http://images.kali.org/kali_linux_nethunter_nexus4.zip";;
			*) url="http://sourceforge.net/projects/kaliflashutility/files/All/kali-utilities.zip/download";;
		esac

	echo "Downloading Kali Utilities. (This could take a while!)"
	echo ""
	curl -L -o $devicedir/kali-utilities.zip $url --progress-bar;;
esac
clear
}

###################
###Unlock Device###
###################
f_unlock(){
case $currentdevice in
	flounder|shamu)
		clear
		echo "Due to a new security feature in Android, you must enable OEM Unlock by:"
		echo "1. Open settings application"
		echo "2. Scroll down to 'About Device' and tap on Build Number 7 times"
		echo "3. Go back to main settings menu and tap Developer Options"
		echo "4. Enable the 'Enable OEM Unlock' box"
		echo ""
		read -p "Press [Enter] to continue" null;;
	*) clear;;
esac

echo "WARNING: This step will erase your device if your bootloader is locked!"
echo "If your bootloader is already unlocked, this will not affect your device."
echo ""
echo "Boot into the bootloader by turning off the device and holding the volume down and power button."
read -p "Press [Enter] to continue." null
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
read -p "Press [Enter] to continue" null
clear
}

####################
###Flash MultiROM###
####################
f_multirom(){
clear
echo "Boot into the bootloader by turning off the device and holding the volume down and power button."
echo "DO NOT touch your device during this process unless told to do so."
echo ""
read -p "Press [Enter] to continue." null

clear
echo "Flashing TWRP"
$fastboot flash recovery $devicedir/twrp.img

clear
echo "Booting into recovery"
$fastboot boot $devicedir/twrp.img
sleep 30

clear
echo "Booting into recovery (again)"
$adb reboot recovery
sleep 30

clear
echo "Moving files to device to install"
$adb push $devicedir/base-kernel${kerneltype}.zip /sdcard/kalitmp/base-kernel.zip
$adb push $devicedir/multirom.zip /sdcard/kalitmp/multirom.zip
$adb shell "echo -e 'print #############################\nprint #####Installing MultiROM#####\nprint #############################\ninstall /sdcard/kalitmp/multirom.zip\nprint ###########################\nprint #####Installing Kernel#####\nprint ###########################\ninstall /sdcard/kalitmp/base-kernel.zip\ncmd rm -rf /sdcard/kalitmp\ncmd reboot\n' > /cache/recovery/openrecoveryscript"
$adb reboot recovery
clear
}

###############
###Flash All###
###############
f_kali(){
clear
echo "Boot into recovery by turning the device off and pressing and holding volume up and power."
echo "If you are already in recovery, make sure you are at the home screen."
echo ""
read -p "Press [Enter] to continue." null

clear
echo "Tap Advanced > MultiROM > Add ROM > Next > ADB Sideload"
echo ""
read -p "Press [Enter] to continue." null

clear
echo "Flashing ROM"
echo ""
$adb sideload $devicedir/$rom.zip
echo ""
read -p "Press [Enter] when flashing is complete, or [R] to retry." choice
case $choice in
	r) f_kalirom;;
	*) clear;;
esac

clear
echo "Press the home button in the bottom left, then press:"
echo "Advanced > MultiROM > List ROMs > sideload > Rename"
echo "Then rename the ROM to 'Kali'"
echo ""
read -p "Press [Enter] to continue" null

clear
echo "Pushing files to device"
echo ""

$adb shell mkdir /sdcard/kalitmp
$adb shell mkdir /sdcard/multirom/roms/Kali
$adb shell mkdir /sdcard/multirom/roms/Kali/cache
$adb shell mkdir /sdcard/multirom/roms/Kali/cache/recovery
$adb push $devicedir/$rom.zip /sdcard/kalitmp/Kali.zip
$adb push $commondir/$gapps-gapps.zip /sdcard/kalitmp/gapps.zip
$adb push $commondir/su.zip /sdcard/kalitmp/su.zip
$adb push $devicedir/kali-utilities.zip /sdcard/kalitmp/utilities.zip

clear
echo "Creating recovery script and pushing to device"
$adb shell "echo -e 'print ##########################\nprint #####Installing GApps#####\nprint ##########################\ninstall /sdcard/kalitmp/gapps.zip\nprint ############################\nprint #####Installing SuperSU#####\nprint ############################\ninstall /sdcard/kalitmp/su.zip\nprint #########################\nprint #####Installing Kali#####\nprint #########################\ninstall /sdcard/kalitmp/utilities.zip\ncmd rm -rf /sdcard/kalitmp\ncmd reboot\n' > data/media/0/multirom/roms/Kali/cache/recovery/openrecoveryscript"

clear
echo "Rebooting into recovery"
$adb reboot recovery

clear
echo "Flashing will take a while, anywhere between 30-45 minutes. Please be patient!"
echo ""
read -p "Press [Enter] when flashing is complete" null

clear
echo "Congratulations! You now Kave Kali NetHunter on your device!"
echo ""
read -p "Press [Enter] to return to main menu" null
clear
}

###########################
###Kali Without MultiROM###
###########################
f_kalionly(){
clear
echo "Your current ROM MUST BE based off of stock/AOSP. If it is not, you WILL have problems."
echo ""
read -p "Press [Enter] to continue" null

clear
echo "Boot into the bootloader by turning off the device and holding the volume down and power button."
echo "DO NOT touch your device during this process unless told to do so."
echo ""
read -p "Press [Enter] to continue." null

clear
echo "Flashing TWRP"
$fastboot flash recovery $devicedir/stock-twrp.img

clear
echo "Booting into recovery"
$fastboot boot $devicedir/stock-twrp.img
sleep 30

clear
echo "Booting into recovery (again)"
$adb reboot recovery
sleep 30

clear
echo "Pushing files to device"
$adb shell mkdir /sdcard/kalitmp
$adb push $commondirdir/su.zip /sdcard/kalitmp/su.zip
$adb push $devicedir/kali-utilities.zip /sdcard/kalitmp/kali-utilities.zip
$adb shell "echo -e 'print ############################\nprint #####Installing SuperSU#####\nprint ############################\ninstall /sdcard/kali/su.zip\nprint #########################\nprint #####Installing Kali#####\nprint #########################\ninstall /sdcard/kali/kali-utilities.zip\ncmd rm -rf /sdcard/kalitmp\ncmd reboot\n' > /cache/recovery/openrecoveryscript"
$adb reboot recovery

clear
echo "Flashing will take a while, anywhere between 30-45 minutes. Please be patient!"
echo ""
read -p "Press [Enter] when flashing is complete" null

clear
echo "Congratulations! You now Kave Kali NetHunter on your device!"
echo ""
read -p "Press [Enter] to return to main menu" null
clear
}

##################
###Kali No TWRP###
##################
f_kalinotwrp(){
clear
echo "Your current ROM MUST BE based off of stock/AOSP. If it is not, you WILL have problems."
echo ""
read -p "Press [Enter] to continue" null

clear
echo "Boot into recovery by turning the device off and pressing and holding volume up and power."
echo "DO NOT touch your device during this process unless told to do so."
echo ""
read -p "Press [Enter] to continue" null

clear
echo "Moving files to device to install"
$adb shell mkdir /sdcard/kalitmp
$adb push $commondirdir/su.zip /sdcard/kalitmp/su.zip
$adb push $devicedir/kali-utilities.zip /sdcard/kalitmp/kali-utilities.zip
$adb shell "echo -e 'print ############################\nprint #####Installing SuperSU#####\nprint ############################\ninstall /sdcard/kali/su.zip\nprint #########################\nprint #####Installing Kali#####\nprint #########################\ninstall /sdcard/kali/kali-utilities.zip\ncmd rm -rf /sdcard/kalitmp\ncmd reboot\n' > /cache/recovery/openrecoveryscript"
$adb reboot recovery
clear
clear
echo "Flashing will take a while, anywhere between 30-45 minutes. Please be patient!"
echo ""
read -p "Press [Enter] when flashing is complete" null

clear
echo "Congratulations! You now Kave Kali NetHunter on your device!"
echo ""
read -p "Press [Enter] to return to main menu" null
clear
}

#####################
###Remove MultiROM###
#####################
f_rmmultirom(){
clear
echo "Boot into the bootloader by turning off the device and holding the volume down and power button."
echo ""
read -p "Press [Enter] to continue." null

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
$adb shell mkdir /sdcard/kalitmp
$adb push $devicedir/rm-multirom.zip /sdcard/kalitmp/rm-multirom.zip
$adb shell "echo -e 'print ###########################\nprint #####Removing MultiROM#####\nprint ###########################\ninstall /sdcard/kalitmp/rm-multirom.zip\ncmd rm -rf /sdcard/kalitmp\ncmd reboot\n' > /cache/recovery/openrecoveryscript"
$adb reboot recovery
clear
}

######################
###Restore to stock###
######################
f_restore(){
clear
echo "WARNING: THIS WILL DELETE ALL FILES ON YOUR NEXUS DEVICE. DO NOT CONTINUE IF YOU WISH TO"
echo "KEEP YOUR FILES."
echo ""
read -p "Press [Enter] to continue, or [Q] to go back" choice

case $choice in
	q) f_menu;;
	*) clear;;
esac

case $currentdevice in
flo)
	restoredir="$devicedir/razor-lrx21p"
	url="https://dl.google.com/dl/android/aosp/razor-lrx21p-factory-ba55c6ab.tgz";;
deb)
	### Change this when the Lollipop image comes out!
	restoredir="$devicedir/razorg-ktu84p"
	url="https://dl.google.com/dl/android/aosp/razorg-ktu84p-factory-f21762aa.tgz";;
grouper)
	restoredir="$devicedir/nakasi-lrx21p"
	url="https://dl.google.com/dl/android/aosp/nakasi-lrx21p-factory-93daa4d3.tgz";;
tilapia)
	### Change this when the Lollipop image comes out!
	restoredir="$devicedir/nakasig-ktu84p"
	url="https://dl.google.com/dl/android/aosp/nakasig-ktu84p-factory-0cc2750b.tgz";;
hammerhead)
	restoredir="$devicedir/hammerhead-lrx21o"
	url="https://dl.google.com/dl/android/aosp/hammerhead-lrx21o-factory-01315e08.tgz";;
manta)
	restoredir="$devicedir/mantaray-lrx21p"
	url="https://dl.google.com/dl/android/aosp/mantaray-lrx21p-factory-ad2499ea.tgz";;
mako)
	restoredir="$devicedir/occam-lrx21t"
	url="https://dl.google.com/dl/android/aosp/occam-lrx21t-factory-51cee750.tgz";;
flounder)
	restoredir="$devicedir/volantis-lrx21q"
	url="https://dl.google.com/dl/android/aosp/volantis-lrx21q-factory-10521789.tgz";;
shamu)
	### Change this when the image comes out!
	clear
	echo "No downloads avaliable yet. Please try again later."
	echo ""
	read -p "Press [Enter] to continue."
	clear
	f_menu;;
	#For later use
	#restoredir="$devicedir/shamu-???????"
	#url="???????"
esac

echo "Downloading restore file"
echo ""
curl -L -o $devicedir/restore.tgz $url --progress-bar
clear
echo "Unzipping restore file"
cd $devicedir
gunzip -c restore.tgz | tar xopf -
cd $restoredir
clear
echo "Please reboot into the bootloader by turning the device off and holding the volume down and"
echo "power buttons."
echo ""
read -p "Press [Enter] to continue" null
clear
echo "Flashing stock ROM"
sleep 1
clear
sh ./flash-all.sh
rm -rf $restoredir
cd ~/
clear
clear
}

############
###Update###
############
f_update(){
unamestr=`uname`
case $unamestr in
Darwin)
	self=$BASH_SOURCE
	curl -o /tmp/kfu.sh 'https://raw.githubusercontent.com/photonicgeek/Kali-Flash-Utility/master/kfu.sh'  --progress-bar
	clear
	rm -rf $self
	mv /tmp/kfu.sh $self
	rm -rf /tmp/kfu.sh
	chmod 755 $self
	exec $self;;
*)
	self=$(readlink -f $0)
	curl -L -o $self 'https://raw.githubusercontent.com/photonicgeek/Kali-Flash-Utility/master/kfu.sh' --progress-bar
	clear
	exec $self;;
esac
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
	clear;;
N|n )
	clear
	echo "Keeping files..."
	sleep 2
	clear;;
esac
}

f_deviceselect
