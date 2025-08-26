# Minecraft Mods Auto-Installer

This package contains everything needed to automatically install Forge 47.4.0 for Minecraft 1.20.1 and all the required mods.

## What This Does

1. Downloads Forge 47.4.0 installer automatically
2. Runs the Forge installer for you
3. Copies all 19 mods to your `.minecraft/mods` folder
4. Sets up everything so you can play immediately

## Prerequisites

Before running the installer, make sure you have:

- **Java 17 or later** installed ([Download from Adoptium](https://adoptium.net/))
- **Minecraft Launcher** installed and working
- **Internet connection** (to download Forge)

## Installation Steps

### Option 1: Super Easy (Recommended)
1. Double-click `Install Mods.bat`
2. Follow the prompts
3. Done!

### Option 2: Manual PowerShell
1. Right-click `install_mods.ps1`
2. Select "Run with PowerShell"
3. Follow the prompts

## What Happens During Installation

1. **Downloads Forge**: Automatically downloads the Forge 47.4.0 installer
2. **Checks Java**: Verifies Java is installed
3. **Installs Forge**: Opens the Forge installer (you'll need to click "Install client")
4. **Copies Mods**: Copies all 19 mods to your Minecraft mods folder
5. **Cleanup**: Removes temporary files

## After Installation

1. Open **Minecraft Launcher**
2. In the version dropdown, select **"1.20.1-forge-47.4.0"**
3. Click **Play**
4. The first launch might take longer as Forge initializes

## Included Mods

The installer will copy these mods to your Minecraft:

- Apocalypse Rebooted
- Car Mod
- Crust
- Entity Culling
- FerriteCore
- GeckoLib
- Immersive Vehicles
- Immersive Aircraft
- JEI (Just Enough Items)
- ModernFix
- MTS Official Pack
- Plane Mod
- Prefab
- Small Ships
- TACZ
- TACZ Fallout
- Warfare Wings
- Zombie Extreme Mod

## Troubleshooting

### "Java is not installed"
- Download and install Java 17+ from [Adoptium](https://adoptium.net/)
- Restart your computer
- Run the installer again

### "Forge installer failed"
- Check your internet connection
- Try running the script as administrator
- Make sure Minecraft Launcher is installed

### "Mods not showing up"
- Make sure you selected "1.20.1-forge-47.4.0" in the launcher
- Check that the mods are in `%appdata%\.minecraft\mods\`
- Try restarting the Minecraft Launcher

### "Script won't run"
- Right-click the `.bat` file and select "Run as administrator"
- Or try running the PowerShell script directly

## File Structure

```
minecraft-mods/
├── mods/                    # All your mod files
├── install_mods.ps1         # Main installation script
├── Install Mods.bat         # Easy launcher
└── INSTALLATION_INSTRUCTIONS.md  # This file
```

## Support

If you encounter any issues:
1. Check the troubleshooting section above
2. Make sure all prerequisites are met
3. Try running as administrator
4. Check that all files are in the same folder

---

**Note**: This installer is designed to be as simple as possible. Just double-click and follow the prompts!
