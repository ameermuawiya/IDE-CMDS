clear
getpermisionsdcard=$(ls -l /sdcard/ 2>/dev/null)
if [ "$getpermisionsdcard" == "" ]; then
    echo -e "\e[1;37m[!] You should grant access to storage on this device."
    yes y | termux-setup-storage
    clear
    echo -e "\e[1;37m[i] Automatically go to next step after 5 seconds."
    sleep 5
fi

clear
echo -e "\e[1;37m[!] Warning and do not ignore!"
echo -e "\e[1;37mMake sure you have at least 16 GB of free storage."
read -r -t 60 -n 1 _ || true

clear
echo -e '\e[1;37m[i] Installing packages...\e[0m'
apt update
yes y | apt upgrade -y
apt install x11-repo -y
apt install proot-distro aria2 termux-x11 -y

clear
echo -e '\e[1;37m[i] Installing Linux...\e[0m'
proot-distro install debian 2>/dev/null || true

# Creating Debian Menu Launcher
cat > "$HOME/debian" <<'EOF'
#!/data/data/com.termux/files/usr/bin/bash
clear
echo "Debian Menu"
echo "1. Open Debian GUI"
echo "2. Install/Manage Android Studio"
echo "Other. Exit"
read -n 1 opt
case "$opt" in
1)
    am start --user 0 -n com.termux.x11/com.termux.x11.MainActivity
    termux-x11 -xstartup "bash -c 'fluxbox & thunar & sleep infinity'"
    ;;
2)
    proot-distro login debian -- bash -c "curl -sL https://raw.githubusercontent.com/ameermuawiya/IDE-CMDS/main/ide/androidstudio/studio-menu.sh | bash"
    ;;
*)
    exit 0
    ;;
esac
EOF
chmod +x "$HOME/debian"

# Creating Kill Launcher
cat > "$HOME/kill" <<'EOF'
#!/data/data/com.termux/files/usr/bin/bash
pkill -9 -f termux-x11 >/dev/null 2>&1
pkill -9 -f proot-distro >/dev/null 2>&1
pkill -9 -f proot >/dev/null 2>&1
pkill -9 -f debian >/dev/null 2>&1
pkill -9 -f fluxbox >/dev/null 2>&1
pkill -9 -f thunar >/dev/null 2>&1
pkill -9 -f dbus-launch >/dev/null 2>&1
pkill -9 -f studio.sh >/dev/null 2>&1
pkill -9 -f java >/dev/null 2>&1
pkill -9 -f adb >/dev/null 2>&1
pkill -9 -f app_process >/dev/null 2>&1
clear
echo "All processes stopped."
EOF
chmod +x "$HOME/kill"

# Running Studio Menu via Link to maintain flow
proot-distro login debian -- bash -c "curl -sL https://raw.githubusercontent.com/ameermuawiya/IDE-CMDS/main/ide/androidstudio/studio-menu.sh | bash"

clear
echo -e '\e[1;37m[i] Logging in...\e[0m'
proot-distro login debian
