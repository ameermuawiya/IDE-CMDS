chmod -x /etc/profile.d/installstudio.sh

apt update
apt upgrade -y

apt install sudo xterm thunar fluxbox default-jdk android-tools-adb aapt git -y
# Required native libraries for Android Studio internal UI panels (Gradle Assistant, Project Structure, Tool Windows)
apt install -y libjna-java libx11-xcb1 libxcomposite1 libxcursor1 libxdamage1 libxi6 libxtst6 libnss3 libatk-bridge2.0-0 libgtk-3-0 libgbm1 libasound2

useradd -m devroom
passwd -d devroom
usermod -s /bin/bash devroom
echo 'devroom ALL=(ALL) ALL' > /etc/sudoers.d/devroom
chmod 440 /etc/sudoers.d/devroom

# Link system JDK to Android Studio JBR
if [ -d /Apps/IDE/android-studio ]; then
    ln -sf /usr/lib/jvm/java-21-openjdk-arm64 /Apps/IDE/android-studio/jbr
fi

# Cleanup
rm -f /etc/profile.d/installstudio.sh

# Final clear and message
clear
echo "----------------------------------------"
echo "Setup completed successfully"
echo "----------------------------------------"
echo ""
echo "Start Android Studio:"
echo "  ./studio.sh"
echo ""
echo "Force stop Android Studio and all services:"
echo "  ./kill"
echo ""
