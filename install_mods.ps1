# Minecraft Mods Auto-Installer Script (Simple Version)
# This script downloads Forge 47.4.0 for Minecraft 1.20.1 and installs all mods

Write-Host "=== Minecraft Mods Auto-Installer ===" -ForegroundColor Green
Write-Host "This script will install Forge 47.4.0 and copy all mods to your Minecraft installation." -ForegroundColor Yellow
Write-Host ""

# Check if running as administrator
$isAdmin = ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")
if (-not $isAdmin) {
    Write-Host "Warning: This script is not running as administrator." -ForegroundColor Yellow
    Write-Host "Some operations might require elevated privileges." -ForegroundColor Yellow
    Write-Host ""
}

# Define paths
$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$modsSourceDir = Join-Path $scriptDir "mods"
$minecraftDir = Join-Path $env:APPDATA ".minecraft"
$modsDir = Join-Path $minecraftDir "mods"
$tempDir = Join-Path $env:TEMP "minecraft-forge-installer"

# Create temp directory
if (-not (Test-Path $tempDir)) {
    New-Item -ItemType Directory -Path $tempDir -Force | Out-Null
}

# Step 1: Download Forge Installer
Write-Host "Step 1: Downloading Forge 47.4.0 installer..." -ForegroundColor Cyan
$forgeUrl = "https://maven.minecraftforge.net/net/minecraftforge/forge/1.20.1-47.4.0/forge-1.20.1-47.4.0-installer.jar"
$forgeInstaller = Join-Path $tempDir "forge-1.20.1-47.4.0-installer.jar"

try {
    Write-Host "Downloading from: $forgeUrl" -ForegroundColor Gray
    Invoke-WebRequest -Uri $forgeUrl -OutFile $forgeInstaller -UseBasicParsing
    Write-Host "[OK] Forge installer downloaded successfully!" -ForegroundColor Green
} catch {
    Write-Host "[ERROR] Failed to download Forge installer: $($_.Exception.Message)" -ForegroundColor Red
    Write-Host "Please check your internet connection and try again." -ForegroundColor Yellow
    exit 1
}

# Step 2: Check if Java is installed
Write-Host "`nStep 2: Checking Java installation..." -ForegroundColor Cyan
$javaPath = Get-Command java -ErrorAction SilentlyContinue
if (-not $javaPath) {
    Write-Host "[ERROR] Java is not installed or not in PATH!" -ForegroundColor Red
    Write-Host "Please install Java 17 or later from: https://adoptium.net/" -ForegroundColor Yellow
    Write-Host "After installing Java, run this script again." -ForegroundColor Yellow
    exit 1
} else {
    Write-Host "[OK] Java found: $($javaPath.Source)" -ForegroundColor Green
}

# Step 3: Run Forge Installer
Write-Host "`nStep 3: Installing Forge..." -ForegroundColor Cyan
Write-Host "The Forge installer will open. Please follow these steps:" -ForegroundColor Yellow
Write-Host "1. Click 'Install client'" -ForegroundColor White
Write-Host "2. Wait for installation to complete" -ForegroundColor White
Write-Host "3. Click 'OK' when done" -ForegroundColor White
Write-Host ""

try {
    Start-Process -FilePath "java" -ArgumentList "-jar", $forgeInstaller -Wait
    Write-Host "[OK] Forge installation completed!" -ForegroundColor Green
} catch {
    Write-Host "[ERROR] Failed to run Forge installer: $($_.Exception.Message)" -ForegroundColor Red
    exit 1
}

# Step 4: Create mods directory if it doesn't exist
Write-Host "`nStep 4: Setting up mods directory..." -ForegroundColor Cyan
if (-not (Test-Path $modsDir)) {
    New-Item -ItemType Directory -Path $modsDir -Force | Out-Null
    Write-Host "[OK] Created mods directory: $modsDir" -ForegroundColor Green
} else {
    Write-Host "[OK] Mods directory already exists: $modsDir" -ForegroundColor Green
}

# Step 5: Copy mods
Write-Host "`nStep 5: Copying mods..." -ForegroundColor Cyan
if (-not (Test-Path $modsSourceDir)) {
    Write-Host "[ERROR] Mods source directory not found: $modsSourceDir" -ForegroundColor Red
    Write-Host "Please make sure this script is in the same directory as the 'mods' folder." -ForegroundColor Yellow
    exit 1
}

$modFiles = Get-ChildItem -Path $modsSourceDir -Filter "*.jar" -ErrorAction SilentlyContinue
if ($modFiles.Count -eq 0) {
    Write-Host "[ERROR] No .jar mod files found in: $modsSourceDir" -ForegroundColor Red
    exit 1
}

$copiedCount = 0
foreach ($modFile in $modFiles) {
    $destinationPath = Join-Path $modsDir $modFile.Name
    try {
        Copy-Item -Path $modFile.FullName -Destination $destinationPath -Force
        Write-Host "[OK] Copied: $($modFile.Name)" -ForegroundColor Green
        $copiedCount++
    } catch {
        Write-Host "[ERROR] Failed to copy $($modFile.Name): $($_.Exception.Message)" -ForegroundColor Red
    }
}

Write-Host "`n[OK] Successfully copied $copiedCount mods to: $modsDir" -ForegroundColor Green

# Step 6: Cleanup
Write-Host "`nStep 6: Cleaning up temporary files..." -ForegroundColor Cyan
try {
    Remove-Item -Path $tempDir -Recurse -Force -ErrorAction SilentlyContinue
    Write-Host "[OK] Cleanup completed!" -ForegroundColor Green
} catch {
    Write-Host "Warning: Could not clean up temporary files: $($_.Exception.Message)" -ForegroundColor Yellow
}

# Final instructions
Write-Host "`n=== Installation Complete! ===" -ForegroundColor Green
Write-Host "Your Minecraft is now ready with Forge 47.4.0 and all mods installed!" -ForegroundColor Green
Write-Host ""
Write-Host "To play:" -ForegroundColor Yellow
Write-Host "1. Open Minecraft Launcher" -ForegroundColor White
Write-Host "2. Select '1.20.1-forge-47.4.0' from the version dropdown" -ForegroundColor White
Write-Host "3. Click Play!" -ForegroundColor White
Write-Host ""
Write-Host "Note: The first launch might take longer as Forge initializes." -ForegroundColor Cyan
Write-Host "Press any key to exit..." -ForegroundColor Gray
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
