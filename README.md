# Android Studio on Termux (ARM64)

Run Android Studio on Termux using Debian and Termux X11 (ARM64).

---

## Installation

Copy and paste this command into **Termux**:

```bash
curl -H 'Cache-Control: no-cache' -o installstudio.sh https://raw.githubusercontent.com/ameermuawiya/IDE-CMDS/main/ide/androidstudio/install1.sh && chmod +rwx installstudio.sh && ./installstudio.sh && rm installstudio.sh && clear
```

---

## Android Studio Source Menu

During installation, you will see a menu with three options:

1. Install default Android Studio version  
2. Install latest Android Studio version  
3. Install Android Studio from local storage  

If you choose option **3**, enter the full file path, for example:

```text
/sdcard/Download/android-studio.tar.gz
```

Confirm by typing `y`.

---

## Start Android Studio

After installation completes, start Android Studio with:

```bash
./studio.sh
```

---

## Stop Android Studio & Termux X11

To force stop Android Studio and all related processes:

```bash
./kill
```

---

## Troubleshooting (Project & Gradle Issues)

If you face any of the following problems:
- Project window closes after clicking **Finish**
- Gradle settings screen keeps loading forever
- Project does not open or sync

Follow the steps below.

---

### How to run the fix commands

You can run commands in **either** way:

**Option 1: Debian GUI**
- Open Debian
- Two-finger tap → Applications → Terminal

**Option 2: From Termux**
```bash
proot-distro login debian
```

---

### Step 1: Fix Java Runtime (JBR) & Gradle Loading

This fixes:
- Project closing issue
- Gradle screen stuck on loading

```bash
ln -sf /usr/lib/jvm/java-21-openjdk-arm64 /Apps/IDE/android-studio/jbr
```

---

### Step 2: Fix SDK platform-tools path (if needed)

```bash
cd ~/Android/Sdk && mv platform-tools2/* platform-tools/ 2>/dev/null; rm -rf platform-tools2
```

---

### Final Step: Set Gradle JDK in Android Studio

Open Android Studio and go to:

```
Settings > Build, Execution, Deployment > Build Tools > Gradle
```

Set **Gradle JDK** to:

```text
/usr/lib/jvm/java-21-openjdk-arm64
```

(Using `/usr/lib/jvm/` also works.)

---

## Credits

Original scripts: **AnBui2004**  
Improvements & updates: **Ameer Muawiya**
