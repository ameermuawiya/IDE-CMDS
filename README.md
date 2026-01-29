# Android Studio on Termux

Run Android Studio on Termux using Debian (proot-distro) and Termux X11.

---

## Required Apps

- **Termux** — [Download from here](https://github.com/termux/termux-app)
- **Termux X11** — [Download from here](https://github.com/termux/termux-x11)

---

<details>
<summary><b>About the recommended Termux build</b></summary>

<br>

This Termux build allows full access to its files.

You can view, edit, delete, and add files using file managers such as **MT Manager**.

**Enable Termux access in MT Manager (SAF):**
1. Open MT Manager  
2. Tap ☰ → ⋮  
3. Tap **Add local storage**  
4. Android file picker (SAF) opens  
5. Tap ☰ → select **Termux**  
6. Allow access  

All Termux files will now be visible and editable.

</details>

---

## Installation

Run this command inside Termux:

```bash
curl -H 'Cache-Control: no-cache' -o installstudio.sh https://raw.githubusercontent.com/ameermuawiya/IDE-CMDS/main/ide/androidstudio/install1.sh && chmod +rwx installstudio.sh && ./installstudio.sh && rm installstudio.sh && clear
```

---

<details>
<summary><b>Android Studio source selection</b></summary>

<br>

During installation, a menu is shown where you can:

- Select an Android Studio version (latest first)
- Install from local storage
- Skip installation if already installed

If Android Studio already exists, its version is detected and shown.  
Reinstallation is still possible.

</details>

---

## Start Android Studio

```bash
./studio.sh
```

---

## Open Debian Only

```bash
./debian
```

---

## Stop Everything

```bash
./kill
```

---

## Credits

Base scripts: AnBui2004  
Automation and maintenance: Ameer Muawiya
