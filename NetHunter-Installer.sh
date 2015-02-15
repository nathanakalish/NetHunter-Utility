#!/bin/bash
scriptversion=0.1
unamestr=`uname`

nhi_versioncheck(){
  clear
  echo "Checking for updates."
  newscriptver="null"
  curl -o ~/nhi.sh 'https://raw.githubusercontent.com/photonicgeek/NetHunter-Utility/master/NetHunter-Installer.sh' --progress-bar
  chmod 755 ~/nhi.sh
  newscriptver=$(sed '2q;d' ~/nhi.sh | cut -d"=" -f2)
  clear
  vercomp "$newscriptver" "$scriptversion"
  case $? in
    0)
      echo "Script is up to date!"
      sleep 3;;
    1)
      echo "New script version found. Updating."
      case $unamestr in
        Darwin) self=$BASH_SOURCE;;
        *) self=$(readlink -f $0);;
      esac
      mv ~/nhi.sh $self
      sleep 3
      echo "Restarting script."
      exec $self;;
    2)
      echo "Local version greater than github version. Keeping local copy."
      sleep 3;;
    3)
      echo "There was an error determinig the version. Keeping Local copy."
      sleep 3;;
  esac
}

nhi_deviceselect(){
  clear
  echo "NetHunter Installer v$scriptversion"
  echo "Select your device:"
  echo ""
  echo "[1]  Nexus 4   2012   Phone       [Mako]"
  echo "[2]  Nexus 5   2013   Phone       [Hammerhead]"
  echo "[3]  Nexus 6   2014   Phone       [Shamu]"
  echo ""
  echo "[4]  Nexus 7   2012   Wifi Only   [Grouper]"
  echo "[5]  Nexus 7   2012   Cellular    [Tilapia]"
  echo "[6]  Nexus 7   2013   Wifi Only   [Flo]"
  echo "[7]  Nexus 7   2013   LTE         [Deb]"
  echo ""
  echo "[8]  Nexus 9   2014   LTE or Wifi [Flounder]"
  echo "[9]  Nexus 10  2012   Wifi Only   [Manta]"
  echo ""
  echo "[10] Other Options"
  echo ""
  echo "[Q] Exit"
  echo ""
  read -p "Please make a selection: " device

  case $device in
    1)
      currentdevice="mako"
      currentmodel="Nexus 4 2012";;
    2)
      currentdevice="hammerhead"
      currentmodel="Nexus 5 2013";;
    3)
      currentdevice="shamu"
      currentmodel="Nexus 6 2014";;
    4)
      currentdevice="grouper"
      currentmodel="Nexus 7 2012 Wifi";;
    5)
      currentdevice="tilapia"
      currentmodel="Nexus 7 2012 3G";;
    6)
      currentdevice="flo"
      currentmodel="Nexus 7 2013 Wifi";;
    7)
      currentdevice="deb"
      currentmodel="Nexus 7 2013 LTE";;
    8)
      currentdevice="flounder"
      currentmodel="Nexus 9 2014 Wifi";;
    9)
      currentdevice="manta"
      currentmodel="Nexus 10 Wifi";;

    10) nhi_options;;
    Q|q) clear; exit;;
    *) nhi_deviceselect;;
  esac
  nhi_setup
  nhi_dl_tools
  nhi_devicesetup
  nhi_mainmenu
}

nhi_mainmenu(){
  clear
  echo "NetHunter Installer v$scriptversion"
  echo "Current Device: $currentmodel ($currentdevice)"
  echo ""
  echo "Please make a selection:"
  echo "[1] Unlock Bootloader"
  echo "[2] Install NetHunter"
  echo "[3] Install Additional Tools"
  echo "[4] Erase device and restore to stock"
  echo ""
  echo "[D] Select A Different Device"
  echo "[Q] Exit"
  echo ""
  read -p "Please make a selection: " menuselection

  case $menuselection in
    1) nhi_unlock; nhi_mainmenu;;
    2) nhi_dl_twrp; nhi_dl_supersu; nhi_dl_nethunter; nhi_install; nhi_mainmenu;;
    3) nhi_nethuntertools; nhi_mainmenu;;
    4) nhi_restore; nhi_mainmenu;;
    D|d) nhi_deviceselect;;
    Q|q) clear; exit;;
    *) nhi_mainmenu;;
  esac
}

nhi_options(){
  Filler
}

nhi_setup(){
  maindir=~/NetHunter
  commondir=$maindir/All
  devicedir=$maindir/$currentdevice
  apkdir=$maindir/APKs
  mkdir -p $commondir
  mkdir -p $apkdir
  mkdir -p $devicedir

  twrpver="2.8.5.0"
  nethunterver="1.10"

  case $unamestr in
    Darwin)
      echo "Installing Xcode CLI utilities. (Follow instructions onscreen)"
      echo ""
      xcode-select --install;;
    *)
      if [[ ! -a /usr/bin/curl ]]; then
        echo "Installing cURL (Password may be required)"
        echo ""
        sudo apt-get -qq update && sudo apt-get -qq -y install curl wget
      else
        sleep 0
      fi;;
  esac

  curl -o $commondir/supersu.py 'https://raw.githubusercontent.com/photonicgeek/NetHunter-Utility/master/supersu.py' --progress-bar
}

nhi_dl_tools(){
  clear
  unamestr=`uname`
  cd $maindir
  if [[ -a $commondir/adb-tools/mac-adb ]]&&[[ -a $commondir/adb-tools/mac-fastboot ]]&&[[ -a $commondir/adb-tools/linux-i386-adb ]]&&[[ -a $commondir/adb-tools/linux-i386-fastboot ]]; then
    echo "ADB and fastboot already installed."
  else
    echo "Downloading ADB and Fastboot"
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
  fi

  case $unamestr in
    Darwin)
    adb=$commondir/adb-tools/mac-adb
    fastboot=$commondir/adb-tools/mac-fastboot;;
    *)
    adb=$commondir/adb-tools/linux-i386-adb
    fastboot=$commondir/adb-tools/linux-i386-fastboot;;
  esac

  chmod 755 $adb
  chmod 755 $fastboot
  $adb kill-server
  $adb start-server
  clear
}

nhi_devicesetup(){
  clear
  $adb start-server
  clear
  echo "Open Settings"
  echo "Tap on 'About Phone' or 'About Tablet'"
  echo "Tap 'Build Number' 7 times"
  echo "Return to the previous menu"
  if [[ $currentdevice == "shamu" ]]||[[ $currentdevice == "flounder" ]]; then
    echo "Enable OEM Unlock"
  fi
  echo "Enable USB Debugging"
  echo "Tap on 'OK'"
  echo "Select to always allow connections from this computer"
  echo "Tap on 'OK'"
  echo ""
  read -p "Press [Enter] to continue" null

  clear
  echo "Waiting for device"
  $adb wait-for-device
  board=$($adb shell getprop ro.product.board)
  board=$(echo $board|tr -d '\r\n')

  if [[ ! $currentdevice == $board ]]; then
    echo "[ERROR]: Device connected is not the same as the device selected"
    echo "Please select the correct device"
    sleep 5
    nhi_deviceselect
  fi

  devicever=$($adb shell getprop ro.build.version.release)
  devicever=$(echo $devicever|tr -d '\r\n')
  vercomp "$devicever" "5.0"
  case $? in
    0) androidver="lollipop";;
    1) androidver="lollipop";;
    2) androidver="kitkat";;
  esac
}

nhi_unlock(){
  clear
  echo "Rebooting to bootloader"
  $adb reboot bootloader
  sleep 10

  clear
  echo "###################################"
  echo "### THIS WILL ERASE YOUR DEVICE ###"
  echo "###################################"
  echo "On the device, use the volume buttoms to select 'Yes'"
  echo ""
  echo "Unlocking"
  $fastboot oem unlock

  echo "Rebooting"
  $fastboot reboot

  clear
  echo "Set up your device again like normal"
  echo ""
  echo "Open Settings"
  echo "Tap on 'About Phone' or 'About Tablet'"
  echo "Tap 'Build Number' 7 times"
  echo "Return to the previous menu"
  echo "Enable USB Debugging"
  echo "Tap on 'OK'"
  echo "Select to always allow connections from this computer"
  echo "Tap on 'OK'"
  echo ""
  echo "Waiting for device"
  $adb wait-for-device
}

nhi_dl_twrp(){
  clear
  echo "Downloading TWRP"
  url="http://techerrata.com/file/twrp2/$currentdevice/openrecovery-twrp-$twrpver-$currentdevice.img"
  curl -o $devicedir/TWRP-$twrpver.img $url --progress-bar
}

nhi_dl_supersu(){
  clear
  echo "Downloading SuperSU"
  cd $commondir
  python $commondir/supersu.py
  cd ~/
}

nhi_dl_nethunter(){
  clear
  echo "Downloading NetHunter (This could take a while)"
  url="http://images.kali.org/kali_linux_nethunter_${nethunterver}_${currentdevice}_${androidver}.zip"
  curl -o $devicedir/nethunter-$currentdevice-$androidver-$nethunterver.zip $url --progress-bar
}

nhi_install(){
  clear
  echo "Installing NetHunter"
  echo "Waiting for device"
  $adb wait-for-device

  clear
  echo "Rebooting to bootloader"
  $adb reboot bootloader
  sleep 10

  clear
  echo "Flashing TWRP"
  $fastboot flash recovery $devicedir/TWRP-$twrpver.img
  $fastboot boot $devicedir/TWRP-$twrpver.img
  sleep 10

  clear
  echo "Moving files to device to be installed"
  echo "Copying SuperSU"
  $adb push $commondir/su.zip /sdcard/nhtmp/su.zip

  clear
  echo "Moving files to device to be installed"
  ehco "Copying NetHunter"
  $adb push $devicedir/nethunter-$currentdevice-$androidver-$nethunterver.zip /sdcard/nhtmp/nethunter.zip

  clear
  echo "Creating recovery script"
  $adb shell "echo -e 'install /sdcard/nhtmp/su.zip\ninstall /sdcard/nhtmp/nethunter.zip\ncmd rm -rf /sdcard/nhtmp\ncmd reboot\n' > /cache/recovery/openrecoveryscript"
  sleep 2

  clear
  echo "Rebooting back into recovery and installing"
  $adb reboot recovery

  sleep 5

  clear
  echo "The install process will take a while. Once it is finished,"
  echo "the device will reboot and NetHunter will have been installed."
  echo ""
  read -p "Press [Enter] to return to the main menu." null
}




vercomp(){
  if [[ $1 == $2 ]]; then
    return 0
  fi

  local IFS=.
  local i ver1=($1) ver2=($2)
  # fill empty fields in ver1 with zeros

  for ((i=${#ver1[@]}; i<${#ver2[@]}; i++)); do
    ver1[i]=0
  done

  for ((i=0; i<${#ver1[@]}; i++)); do
    if [[ -z ${ver2[i]} ]]; then
      # fill empty fields in ver2 with zeros
      ver2[i]=0
    fi
    if ((10#${ver1[i]} > 10#${ver2[i]})); then
      return 1
    fi
    if ((10#${ver1[i]} < 10#${ver2[i]})); then
      return 2
    fi
  done

  return 3
}



nhi_versioncheck
nhi_deviceselect
