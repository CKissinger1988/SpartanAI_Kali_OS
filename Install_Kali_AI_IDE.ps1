# Kali_AI_IDE Installation Guide
# -------------------------------------------------------------------------
# 1. Ensure you have the ISO file (Kali_AI_IDE.iso) in the same directory as this script.
# 2. Insert your USB flash drive.
# 3. Open PowerShell as Administrator.
# 4. Run this script: .\Install_Kali_AI_IDE.ps1
# -------------------------------------------------------------------------

$isoPath = Join-Path $PSScriptRoot "Kali_AI_IDE.iso"
$usbDrive = Read-Host "Enter the drive letter of your USB flash drive (e.g., E)"

if (Test-Path $isoPath) {
    Write-Host "[+] ISO found: $isoPath" -ForegroundColor Green
    Write-Host "[!] WARNING: This will format the entire drive $usbDrive`:. Ensure no data is lost!" -ForegroundColor Red
    $confirm = Read-Host "Are you sure you want to write to drive $usbDrive`:? (y/n)"
    
    if ($confirm -eq 'y') {
        Write-Host "[+] Using Rufus or BalenaEtcher is recommended for stability." -ForegroundColor Cyan
        Write-Host "[+] Please open your preferred flashing tool, select the ISO, and flash to drive $usbDrive`:" -ForegroundColor Cyan
    }
} else {
    Write-Host "[!] ISO not found at $isoPath. Build process may still be running." -ForegroundColor Red
}
