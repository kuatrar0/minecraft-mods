@echo off
title Minecraft Mods Auto-Installer
echo ========================================
echo Minecraft Mods Auto-Installer
echo ========================================
echo.
echo This will install Forge 47.4.0 and copy all mods to your Minecraft.
echo.
echo Requirements:
echo - Java 17 or later must be installed
echo - Minecraft Launcher must be installed
echo - Internet connection required
echo.
pause

echo.
echo Starting installation...
echo.

powershell -ExecutionPolicy Bypass -File "%~dp0install_mods.ps1"

echo.
echo Installation completed!
echo.
pause
