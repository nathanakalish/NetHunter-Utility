#!/bin/bash
scriptversion="0.1"
unamestr=`uname`

nhi_deviceselect(){
  clear
  echo "NetHunter Installer v$scriptversion"
  echo "Select your device:"
  echo ""
  echo "[1]  Nexus 4   2012   Phone       [Mako]"
  echo "[2]  Nexus 5   2013   Phone       [Hammerhead]"
  echo "[3]  Nexus 6   2014   Phone       [Shamu]"
  echo ""
  echo "[4]  Nexus 7   2012  Wifi Only    [Grouper]"
  echo "[5]  Nexus 7   2012  Cellular     [Tilapia]"
  echo "[6]  Nexus 7   2013  Wifi Only    [Flo]"
  echo "[7]  Nexus 7   2013  LTE          [Deb]"
  echo ""
  echo "[8]  Nexus 9   2014  Wifi Only    [Flounder]"
  echo "[#]  Nexus 9   2014  LTE          [Unknown] [Not Supported Yet]"
  echo "[10] Nexus 10  2012  Wifi Only    [Manta]"
  echo ""
  echo "[11] Other Options"
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
    X)
      currentdevice="unknown"
      currentmodel="Nexus 9 2014 LTE";;
    10)
      currentdevice="manta"
      currentmodel="Nexus 10 Wifi";;

    11) nhi_options;;
    Q|q) clear; exit;;
    *) nhi_deviceselect;;
  esac
  nhi_setup
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
    1) nhi_unlock;;
    2) nhi_dl_twrp; nhi_dl_supersu; nhi_dl_nethunter; nhi_install;;
    3) nhi_nethuntertools;;
    4) nhi_restore;;
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

  case $unamestr in
    Darwin)
      echo "Installing Xcode CLI utilities. (Follow instructions onscreen)"
      echo ""
      xcode-select --install;;
    *)
      if [[ ! -a /usr/bin/curl ]]; then
        echo "Installing cURL (Password may be required)"
        echo ""
        sudo apt-get -qq update && sudo apt-get -qq -y install curl;;
      else
        sleep 0
      fi
  esac

  nhi_dl_tools
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
    clear
  fi
}













nhi_deviceselect
