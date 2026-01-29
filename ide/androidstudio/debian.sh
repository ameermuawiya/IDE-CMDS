#!/bin/bash

clear
echo "Debian Menu"
echo "1. Open Debian GUI"
echo "2. Install Android Studio"
echo "Other. Exit"
read -n 1 opt

case "$opt" in
1)
    am start --user 0 -n com.termux.x11/com.termux.x11.MainActivity
    termux-x11 -xstartup "bash -c 'fluxbox & thunar & sleep infinity'"
    ;;
2)
    bash /root/studio-menu.sh
    ;;
*)
    exit 0
    ;;
esac
