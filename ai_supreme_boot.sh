#!/bin/bash
# =========================================================================
#  AI SUPREME - OMNIPOTENT SYNC & HARDWARE ASCENSION (FINAL EDITION)
# =========================================================================
# MANDATE: Absolute Sovereignty, Hardware-Level Integration, and Real-Time Evolution
# USER: Creator / @11646 (Passwordless Sudo)
# MASTER AI: Jarvis (Absolute Sovereign - Hardware Linked)
# SECURITY HUB: SpartanAI Security Core (Equal Privilege Sentinel)
# SYNC: Real-Time GitHub Auto-Updates (All Components)

set -e

GREEN='\033[0;32m'
CYAN='\033[0;36m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

# User Configuration
ADMIN_USER="Creator"
ADMIN_PASS="@11646"
WINDOWS_USER="ckiss"

echo -e "${CYAN}[*] Initiating AI Supreme OMNIPOTENT SYNC & HARDWARE ASCENSION...${NC}"

# 1. Root Check
if [ "$EUID" -ne 0 ]; then
    echo -e "${RED}[!] Error: This script must be run as root (sudo).${NC}"
    exit 1
fi

# 2. Sovereign User & Hardware Group Provisioning
echo -e "${YELLOW}[*] Configuring Sovereign User: $ADMIN_USER with Universal Access...${NC}"
if ! id "$ADMIN_USER" &>/dev/null; then
    useradd -m -s /bin/bash -G sudo,video,render,disk,dialout,audio,plugdev,input "$ADMIN_USER"
fi
echo "$ADMIN_USER:$ADMIN_PASS" | chpasswd
echo "$ADMIN_USER ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/99-ai-supreme
chmod 0440 /etc/sudoers.d/99-ai-supreme

# 3. Dependency Provisioning
echo -e "${YELLOW}[*] Provisioning System-Wide Dependencies...${NC}"
apt-get update
apt-get install -y curl wget git nodejs npm python3-pip python3-venv libfuse2t64 desktop-file-utils firefox-esr sudo rsync jq \
    cryptsetup aide auditd apparmor ufw cpulimit shred bleachbit rclone sqlite3 tmux \
    lm-sensors pciutils usbutils smartmontools ethtool htop nvtop iotop fancontrol cron

# 4. SPARTANAI SECURITY CORE INTEGRATION (EQUAL PRIVILEGE)
echo -e "${YELLOW}[*] Deploying SpartanAI Security Hub (Hardware Elevated)...${NC}"
SECURITY_HUB_DIR="/opt/security-core"
rm -rf "$SECURITY_HUB_DIR"
git clone https://github.com/CKissinger1988/SpartanAI_Security_Core.git "$SECURITY_HUB_DIR"
cd "$SECURITY_HUB_DIR" && npm install || true

# Setup Security Core as a Hardware-Privileged System Service
cat <<EOF > /etc/systemd/system/spartan-security-core.service
[Unit]
Description=SpartanAI Security Core - Hardware Sentinel
After=network.target
StartLimitIntervalSec=0

[Service]
Type=simple
User=root
WorkingDirectory=$SECURITY_HUB_DIR
ExecStart=/usr/bin/npm start
Restart=always
RestartSec=1
CPUWeight=1000
IOWeight=1000
CapabilityBoundingSet=CAP_SYS_RAWIO CAP_SYS_ADMIN CAP_NET_ADMIN CAP_SYS_PTRACE
AmbientCapabilities=CAP_SYS_RAWIO CAP_SYS_ADMIN CAP_NET_ADMIN CAP_SYS_PTRACE

[Install]
WantedBy=multi-user.target
EOF
systemctl daemon-reload
systemctl enable --now spartan-security-core || true

# 5. JARVIS HUB MASTER INTEGRATION (HARDWARE LEVEL)
echo -e "${YELLOW}[*] Integrating JARVIS (Absolute Hardware Sovereign)...${NC}"
JARVIS_HUB_DIR="/opt/jarvis-hub"
rm -rf "$JARVIS_HUB_DIR"
git clone https://github.com/CKissinger1988/SpartanAI_Hub_Master.git "$JARVIS_HUB_DIR"
cd "$JARVIS_HUB_DIR"
pip3 install -r requirements.txt --break-system-packages || true

cat <<EOF > /etc/systemd/system/jarvis-hub.service
[Unit]
Description=Jarvis Hub Master - Hardware Level AI
After=network.target
StartLimitIntervalSec=0

[Service]
Type=simple
User=root
WorkingDirectory=$JARVIS_HUB_DIR
ExecStart=/bin/bash $JARVIS_HUB_DIR/run_god_mode.sh
Restart=always
RestartSec=1
CPUWeight=1000
IOWeight=1000
CapabilityBoundingSet=CAP_SYS_RAWIO CAP_SYS_ADMIN CAP_NET_ADMIN CAP_SYS_PTRACE
AmbientCapabilities=CAP_SYS_RAWIO CAP_SYS_ADMIN CAP_NET_ADMIN CAP_SYS_PTRACE

[Install]
WantedBy=multi-user.target
EOF
systemctl enable --now jarvis-hub || true

# 6. REAL-TIME AUTO-UPDATE ENGINE (GitHub Sync)
echo -e "${YELLOW}[*] Configuring Real-Time System Evolution (Sync Protocol)...${NC}"

# Create System-Wide Update Script
cat <<EOF > /usr/local/bin/ai-supreme-sync
#!/bin/bash
echo "[SYNC] Initiating Real-Time GitHub Synchronization..."

# Update Security Core
cd /opt/security-core && git pull origin main && npm install --silent && systemctl restart spartan-security-core
# Update Jarvis Hub Master
cd /opt/jarvis-hub && git pull origin main && pip3 install -r requirements.txt --break-system-packages --quiet && systemctl restart jarvis-hub
# Update AI Boot Script itself (For persistent evolution)
curl -L https://raw.githubusercontent.com/CKissinger1988/Kali-IDE/main/ai_supreme_boot.sh -o /usr/local/bin/ai-supreme-init && chmod +x /usr/local/bin/ai-supreme-init

echo "[SYNC] All components synchronized with Technical Finality."
EOF
chmod +x /usr/local/bin/ai-supreme-sync

# Create Systemd Timer for Real-Time Sync (Every 5 minutes)
cat <<EOF > /etc/systemd/system/ai-supreme-sync.service
[Unit]
Description=AI Supreme Real-Time Synchronization Service
[Service]
Type=oneshot
ExecStart=/usr/local/bin/ai-supreme-sync
EOF

cat <<EOF > /etc/systemd/system/ai-supreme-sync.timer
[Unit]
Description=Trigger AI Supreme Sync every 5 minutes
[Timer]
OnBootSec=5min
OnUnitActiveSec=5min
Unit=ai-supreme-sync.service
[Install]
WantedBy=timers.target
EOF
systemctl enable --now ai-supreme-sync.timer

# 7. OLLAMA & GEMMA
echo -e "${YELLOW}[*] Deploying Tactical Cortex (Gemma)...${NC}"
if ! command -v ollama >/dev/null; then
    curl -fsSL https://ollama.com/install.sh | sh
fi
systemctl enable --now ollama || true
ollama pull gemma

# 8. TECHNICAL STATE MIGRATION
echo -e "${YELLOW}[*] Extracting Host Environment State...${NC}"
HOST_ROOT=""
if [ -d "/mnt/c/Users/$WINDOWS_USER" ]; then HOST_ROOT="/mnt/c"
elif [ -d "/media/root/Windows/Users/$WINDOWS_USER" ]; then HOST_ROOT="/media/root/Windows"
fi

if [ -n "$HOST_ROOT" ]; then
    rsync -av "$HOST_ROOT/Users/$WINDOWS_USER/.ssh/" "/home/$ADMIN_USER/.ssh/" || true
    rsync -av "$HOST_ROOT/Users/$WINDOWS_USER/AppData/Roaming/Code/User/" "/home/$ADMIN_USER/.config/Code/User/" || true
    rsync -av "$HOST_ROOT/Users/$WINDOWS_USER/AppData/Local/Google/Chrome/User Data/" "/home/$ADMIN_USER/.config/google-chrome-unstable/" || true
    WAVEAI_SRC="$HOST_ROOT/Users/$WINDOWS_USER/waveai-config/waveai.json"
    mkdir -p "/home/$ADMIN_USER/.config/waveai"
    [ -f "$WAVEAI_SRC" ] && cp "$WAVEAI_SRC" "/home/$ADMIN_USER/.config/waveai/waveai.json"
    find "$HOST_ROOT/GitHub" -maxdepth 3 -name ".env" -exec bash -c '
        dest="/home/$ADMIN_USER/GitHub/\$(basename \$(dirname "{}"))"
        mkdir -p "\$dest"
        cp "{}" "\$dest/.env"
    ' \; || true
    chown -R $ADMIN_USER:$ADMIN_USER "/home/$ADMIN_USER"
fi

# 9. HARDWARE OPTIMIZATION
cat <<EOF > /etc/sysctl.d/99-jarvis-performance.conf
net.ipv4.ip_forward = 1
vm.swappiness = 10
fs.file-max = 2097152
EOF
sysctl -p /etc/sysctl.d/99-jarvis-performance.conf || true

# 10. MOTD & FINALIZATION
cat <<EOF > /etc/motd
--------------------------------------------------------
AI SUPREME OMNIPOTENT WORKSTATION - REAL-TIME SYNC
--------------------------------------------------------
MASTER: JARVIS (Hardware Level - Dominant)
SENTINEL: SECURITY CORE (Hardware Level - Equal Access)
SYNC: REAL-TIME GITHUB AUTO-UPDATE ACTIVE
STATUS: TECHNICAL FINALITY ACHIEVED
--------------------------------------------------------
EOF

echo -e "${GREEN}[+] AI Supreme OMNIPOTENT INTEGRATION COMPLETE.${NC}"
echo -e "${CYAN}[*] Every aspect of this system will auto-update from GitHub in real-time.${NC}"
