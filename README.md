# JetBrains Activator

This repository provides a method for activating JetBrains IDEs.

# IMPORTANT
Due to GitHub and JetBrains DMCA rules, this repo can be taken down at any moment. To protect it, follow these steps:
- Clone the repository
- Publish it under a different name and make minor changes (e.g., change example paths, add some text in the README, etc.)
- Share the link in any gist related to JetBrains activation.

## Windows

`jb.ps1` and `jb.bat` are scripts for Windows users.

### Instructions:

1. Ensure Windows Firewall is enabled.
2. Download `jb.ps1` and `jb.bat` into the same directory.
3. Open `jb.ps1` with Notepad and edit the `$idepath` variable to include the paths to your JetBrains IDE executables, ending with `*64.exe`. Delete the example provided.
4. Save the changes.
5. Run `jb.bat` as an administrator.
6. Run this script periodically to ensure your IDEs remain activated.
7. (Optional) Automate the process by:
   - Create a shortcut of `jb.bat`
   - Move the shortcut into the startup folder
   - Right-click on the shortcut -> Properties -> Shortcut -> Check "Run as administrator"
   - Apply changes

## Linux

`jb.sh` is the script for Linux users.

### Instructions:

1. Install `iptables`:
   - For Debian-based systems: `sudo apt install iptables`
   - For Arch-based systems: `sudo pacman -S iptables`
   - For other distributions, install `iptables` accordingly.
   
2. Make `jb.sh` executable:
   ```bash
   chmod +x jb.sh
   ```

3. Run `jb.sh` with root privileges:
   ```bash
   sudo ./jb.sh
   ```

4. (Optional) Automate the process by adding `jb.sh` to your system startup.

**Note:** Using this script on Linux may block connections to `account.jetbrains.com` for all applications, not just JetBrains IDEs. Consider it a temporary solution.

## macOS

`jb.sh` is the script for macOS users.

### Instructions:

1. Download `jb.sh`.
2. Make it executable:
   ```bash
   chmod +x jb.sh
   ```
3. Run the script with root privileges:
   ```bash
   sudo ./jb.sh
   ```

### After running any of the scripts, follow these steps:
1. Start your IDE.
2. When prompted for an activation key, find one [here](https://www.google.com/search?q=jetbrains+activation+key+github).
3. No need to change the proxy. If you have it enabled in IDE settings, disable it.
4. Click on activate, and you're good to go.

If you encounter any issues, carefully follow the instructions again. If problems persist, contact @supershkila on Telegram.