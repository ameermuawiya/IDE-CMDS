clear

getpermisionsdcard=$(ls -l /sdcard/)
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
proot-distro install debian

ROOTFS="$PREFIX/var/lib/proot-distro/installed-rootfs/debian"
SCRIPT_BASE="https://raw.githubusercontent.com/ameermuawiya/IDE-CMDS/main/ide/androidstudio"

# download helper scripts
mkdir -p "$ROOTFS/usr/local/bin"
aria2c -o "$ROOTFS/usr/local/bin/studio-menu.sh" "$SCRIPT_BASE/studio-menu.sh"
aria2c -o "$ROOTFS/usr/local/bin/debian.sh" "$SCRIPT_BASE/debian.sh"

chmod +x "$ROOTFS/usr/local/bin/"*.sh

# call Android Studio install menu INSIDE Debian
proot-distro login debian -- bash /usr/local/bin/studio-menu.sh

# continue normal flow
proot-distro login debian

# kill launcher (unchanged)
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
echo "All Android Studio and X11 processes have been forcefully stopped."
EOF

chmod +x "$HOME/kill"
