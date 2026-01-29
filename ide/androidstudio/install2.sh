chmod -x /etc/profile.d/installstudio.sh

apt update
apt upgrade -y

apt install sudo xterm thunar fluxbox default-jdk android-tools-adb aapt git -y

useradd -m devroom
passwd -d devroom
usermod -s /bin/bash devroom
echo 'devroom ALL=(ALL) ALL' > /etc/sudoers.d/devroom
chmod 440 /etc/sudoers.d/devroom

# JBR link
[ -d /Apps/IDE/android-studio ] && ln -sf /usr/lib/jvm/java-21-openjdk-arm64 /Apps/IDE/android-studio/jbr

# SDK fix
if [ -d /home/devroom/Android/Sdk/platform-tools2 ]; then
    cd /home/devroom/Android/Sdk
    mv platform-tools2/* platform-tools/ 2>/dev/null
    rm -rf platform-tools2
fi

echo "Done. Use ./studio.sh"
rm /etc/profile.d/installstudio.sh
