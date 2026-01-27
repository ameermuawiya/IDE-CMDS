# Android Studio on Termux (ARM64)

Install and run Android Studio on Termux using Debian and Termux X11.

---

## Install

Copy and paste this command in Termux:

```bash
curl -H 'Cache-Control: no-cache' -o installstudio.sh https://raw.githubusercontent.com/ameermuawiya/IDE-CMDS/main/ide/androidstudio/install1.sh && chmod +rwx installstudio.sh && ./installstudio.sh && rm installstudio.sh && clear
```

---

## Android Studio source menu

During installation, you will be asked to choose:

1. Default Android Studio version  
2. Latest Android Studio version  
3. Install from local storage  

For option **3**, enter full file path, for example:
`/sdcard/Download/android-studio.tar.gz` and confirm with `y`.

---

## Start Android Studio

```bash
./studio.sh
```

---

## Stop Android Studio and X11

```bash
./kill
```

---

## Credits

Original scripts by **AnBui2004**  
Improvements and updates by **Ameer Muawiya**
