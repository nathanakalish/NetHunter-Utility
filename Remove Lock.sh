#!/bin/sh
clear
echo "Waiting for device"
adb wait-for-device
clear
echo "Removing password"
echo ""
adb shell am start -n com.android.settings/com.android.settings.ChooseLockGeneric --ez confirm_credentials false --ei lockscreen.password_type 0 --activity-clear-task
echo ""
read -p "Press [Enter] to continue"
clear