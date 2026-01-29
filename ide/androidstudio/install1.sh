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

# ----------------------------------------
# SETUP SCRIPTS IN TERMUX HIDDEN FOLDER
# ----------------------------------------
SCRIPT_DIR="$HOME/.scripts"
mkdir -p "$SCRIPT_DIR"

SCRIPT_BASE="https://raw.githubusercontent.com/ameermuawiya/IDE-CMDS/main/ide/androidstudio"

# Download scripts to Termux storage (Silent)
aria2c -q -o "$SCRIPT_DIR/studio-menu.sh" "$SCRIPT_BASE/studio-menu.sh"
aria2c -q -o "$SCRIPT_DIR/debian.sh" "$SCRIPT_BASE/debian.sh"

chmod +x "$SCRIPT_DIR/studio-menu.sh" "$SCRIPT_DIR/debian.sh"

# ----------------------------------------
# COPY SCRIPTS TO DEBIAN INTERNAL STORAGE
# ----------------------------------------
DEBIAN_ROOT_FS="$PREFIX/var/lib/proot-distro/installed-rootfs/debian/root"

# Copying files ensuring they exist inside Debian for execution
cp "$SCRIPT_DIR/studio-menu.sh" "$DEBIAN_ROOT_FS/studio-menu.sh"
cp "$SCRIPT_DIR/debian.sh" "$DEBIAN_ROOT_FS/debian.sh"

chmod +x "$DEBIAN_ROOT_FS/studio-menu.sh" "$DEBIAN_ROOT_FS/debian.sh"

# ----------------------------------------
# Run Android Studio menu inside Debian automatically
# ----------------------------------------
# This line restores the flow by executing the menu inside Debian immediately
proot-distro login debian -- bash /root/studio-menu.sh

# ----------------------------------------
# FORCE-KILL LAUNCHER
# ----------------------------------------
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

clear
echo -e '\e[1;37m[i] Logging in...\e[0m'
proot-distro login debian
