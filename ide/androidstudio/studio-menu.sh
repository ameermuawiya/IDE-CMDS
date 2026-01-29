#!/bin/bash
STUDIO_DIR="/Apps/IDE/android-studio"
INSTALLED_VERSION=""
if [ -f "$STUDIO_DIR/product-info.json" ]; then
    INSTALLED_VERSION=$(grep -m1 '"dataDirectoryName"' "$STUDIO_DIR/product-info.json" | sed -E 's/.*AndroidStudio([0-9.]+).*/\1/')
fi
if [ "$INSTALLED_VERSION" = "" ] && [ -f "$STUDIO_DIR/build.txt" ]; then
    INSTALLED_VERSION=$(cat "$STUDIO_DIR/build.txt")
fi

clear
echo -e "\e[1;37mSelect Android Studio source:\e[0m"
[ "$INSTALLED_VERSION" != "" ] && echo "Detected: $INSTALLED_VERSION"
echo "1. Panda 1 | 2025.3.1 RC1"
echo "2. Otter 3 | 2025.2.3"
echo "3. 2025.2.2.8"
echo "4. 2024.2.2.14"
echo "5. Install from storage"
echo "6. Skip"
read -p "Enter choice: " studio_choice

STUDIO_MODE="download"
SKIP_STUDIO="no"
case "$studio_choice" in
1) STUDIO_SOURCE="https://edgedl.me.gvt1.com/android/studio/ide-zips/2025.3.1.6/android-studio-panda1-rc1-linux.tar.gz" ;;
2) STUDIO_SOURCE="https://edgedl.me.gvt1.com/android/studio/ide-zips/2025.2.3.9/android-studio-2025.2.3.9-linux.tar.gz" ;;
3) STUDIO_SOURCE="https://redirector.gvt1.com/android/studio/ide-zips/2025.2.2.8/android-studio-2025.2.2.8-linux.tar.gz" ;;
4) STUDIO_SOURCE="https://edgedl.me.gvt1.com/android/studio/ide-zips/2024.2.2.14/android-studio-2024.2.2.14-linux.tar.gz" ;;
5) STUDIO_MODE="local"; read -p "Enter full path: " STUDIO_SOURCE ;;
6) SKIP_STUDIO="yes" ;;
*) exit 1 ;;
esac

if [ "$SKIP_STUDIO" = "no" ]; then
    mkdir -p /Apps/IDE
    cd /Apps/IDE || exit 1
    [ "$STUDIO_MODE" = "download" ] && aria2c -q -x 4 -o studio.tar.gz "$STUDIO_SOURCE" || cp "$STUDIO_SOURCE" studio.tar.gz
    tar -xzf studio.tar.gz && rm studio.tar.gz
    cd android-studio && mv jbr jbr.bak
fi

# Launcher and script download
mkdir -p /Apps/IDE/android-studio
cd /Apps/IDE/android-studio
cat > studio.sh <<'EOF'
am start --user 0 -n com.termux.x11/com.termux.x11.MainActivity && \
termux-x11 -xstartup "bash -c 'fluxbox & thunar & /Apps/IDE/android-studio/bin/studio.sh && sleep infinity'"
EOF
aria2c -q -o startstudio.sh https://raw.githubusercontent.com/ameermuawiya/IDE-CMDS/main/ide/androidstudio/startstudio.sh
aria2c -q -o uninstall.sh https://raw.githubusercontent.com/ameermuawiya/IDE-CMDS/main/ide/androidstudio/uninstall.sh
chmod +x studio.sh startstudio.sh uninstall.sh bin/studio bin/studio.sh

# Run Install2 via Link
curl -sL https://raw.githubusercontent.com/ameermuawiya/IDE-CMDS/main/ide/androidstudio/install2.sh | bash
