#!/bin/bash
# =========================================================================
#  AI SUPREME - MINIMAL KALI BOOTSTRAP BLUEPRINT
# =========================================================================
# MANDATE: Create a minimal AI-centric Kali filesystem.
# WARNING: This script builds a base filesystem. USE ONLY ON A FRESH SYSTEM.

set -e

# Load Environment Variables if present
if [ -f .env ]; then
    export $(grep -v '^#' .env | xargs)
fi

ADMIN_USER="${ADMIN_USER:-Creator}"
if [ -z "$ADMIN_PASS" ]; then
    echo -e "\033[0;31m[!] Error: ADMIN_PASS environment variable not set for bootstrap.\033[0m"
    exit 1
fi

# 1. Initialize Minimal Root
mkdir -p /opt/ai-supreme-minimal
cd /opt/ai-supreme-minimal

# 2. Bootstrap Core
echo "[*] Bootstrapping minimal Kali rootfs..."
debootstrap --variant=minbase --include=bash,apt,curl,git,python3-pip kali-rolling . http://http.kali.org/kali

# 3. Chroot and Configure
mount --bind /proc proc
mount --bind /sys sys
mount --bind /dev dev

cat <<CHROOT_EOF | chroot . /bin/bash
set -e
export DEBIAN_FRONTEND=noninteractive

# Update Sources
echo "deb http://http.kali.org/kali kali-rolling main contrib non-free non-free-firmware" > /etc/apt/sources.list
apt-get update

# Install ONLY AI Supreme Core
apt-get install -y git curl nodejs npm python3-pip sudo

# Install AI Suite
npm install -g @google/gemini-cli
git clone https://github.com/CKissinger1988/SpartanAI_Security_Core.git /opt/security-core
git clone https://github.com/CKissinger1988/SpartanAI_Hub_Master.git /opt/jarvis-hub

# Setup Basic Admin
useradd -m -s /bin/bash $ADMIN_USER || true
echo "$ADMIN_USER:$ADMIN_PASS" | chpasswd
echo "$ADMIN_USER ALL=(ALL) NOPASSWD: /usr/bin/hostnamectl, /usr/sbin/ip, /usr/bin/macchanger, /usr/sbin/macchanger, /usr/bin/systemctl, /usr/bin/sdmem, /usr/bin/mount, /usr/bin/umount, /usr/sbin/chroot" > /etc/sudoers.d/$ADMIN_USER
chmod 0440 /etc/sudoers.d/$ADMIN_USER

CHROOT_EOF

echo "[+] Minimal AI Supreme RootFS Created at /opt/ai-supreme-minimal"
