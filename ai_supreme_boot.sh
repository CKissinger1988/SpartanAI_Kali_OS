#!/bin/bash
# =========================================================================
#  AI SUPREME - APEX SOVEREIGN INTEGRATION (ULTIMATE EDITION)
# =========================================================================
# MANDATE: Absolute Sovereignty, Hardware-Level Integration, and Autonomous Supremacy
# USER: Creator / @11646 (Passwordless Sudo)
# MASTER AI: Jarvis (Hardware Integrated Core)
# SECURITY HUB: SpartanAI Security Core (Equal Access)
# FEATURES: Stealth Layer, Deep Extraction, Genesis Recon, Sovereign Dashboard

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

echo -e "${CYAN}[*] Initiating AI Supreme APEX SOVEREIGN Protocol...${NC}"

# 1. Root Check
if [ "$EUID" -ne 0 ]; then
    echo -e "${RED}[!] Error: This script must be run as root (sudo).${NC}"
    exit 1
fi

# 2. STEALTH LAYER (Network & Identity)
echo -e "${YELLOW}[*] Activating Stealth Layer...${NC}"
apt-get update
apt-get install -y macchanger
# Randomize Hostname
NEW_HOSTNAME="AI-SUPREME-$(head /dev/urandom | tr -dc A-Z0-9 | head -c 6)"
hostnamectl set-hostname "$NEW_HOSTNAME"
echo "127.0.0.1 $NEW_HOSTNAME" >> /etc/hosts

# Randomize MACs for all physical interfaces
for interface in $(ls /sys/class/net | grep -v lo); do
    macchanger -r "$interface" || true
done

# 3. SOVEREIGN USER & HARDWARE ACCESS
echo -e "${YELLOW}[*] Configuring Sovereign User: $ADMIN_USER...${NC}"
if ! id "$ADMIN_USER" &>/dev/null; then
    useradd -m -s /bin/bash -G sudo,video,render,disk,dialout,audio,plugdev,input "$ADMIN_USER"
fi
echo "$ADMIN_USER:$ADMIN_PASS" | chpasswd
echo "$ADMIN_USER ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/99-ai-supreme
chmod 0440 /etc/sudoers.d/99-ai-supreme

# 4. DEPENDENCY PROVISIONING (APEX SUITE)
echo -e "${YELLOW}[*] Provisioning APEX Suite Dependencies...${NC}"
apt-get install -y curl wget git nodejs npm python3-pip python3-venv libfuse2t64 desktop-file-utils firefox-esr sudo rsync jq \
    cryptsetup aide auditd apparmor ufw cpulimit shred bleachbit rclone sqlite3 tmux \
    lm-sensors pciutils usbutils smartmontools ethtool htop nvtop iotop fancontrol cron \
    nmap metasploit-framework wiper p7zip-full

# 5. SPARTANAI SECURITY CORE (HARDWARE SENTINEL)
echo -e "${YELLOW}[*] Deploying SpartanAI Security Core (Equal Access)...${NC}"
SECURITY_HUB_DIR="/opt/security-core"
rm -rf "$SECURITY_HUB_DIR"
git clone https://github.com/CKissinger1988/SpartanAI_Security_Core.git "$SECURITY_HUB_DIR"
cd "$SECURITY_HUB_DIR" && npm install || true

cat <<EOF > /etc/systemd/system/spartan-security-core.service
[Unit]
Description=SpartanAI Security Core - Hardware Sentinel
After=network.target
[Service]
Type=simple
User=root
WorkingDirectory=$SECURITY_HUB_DIR
ExecStart=/usr/bin/npm start
Restart=always
RestartSec=1
CPUWeight=1000
CapabilityBoundingSet=CAP_SYS_RAWIO CAP_SYS_ADMIN CAP_NET_ADMIN CAP_SYS_PTRACE
AmbientCapabilities=CAP_SYS_RAWIO CAP_SYS_ADMIN CAP_NET_ADMIN CAP_SYS_PTRACE
[Install]
WantedBy=multi-user.target
EOF
systemctl daemon-reload
systemctl enable --now spartan-security-core || true

# 6. JARVIS HUB MASTER (HARDWARE LEVEL)
echo -e "${YELLOW}[*] Integrating JARVIS (Absolute Hardware Sovereign)...${NC}"
JARVIS_HUB_DIR="/opt/jarvis-hub"
rm -rf "$JARVIS_HUB_DIR"
git clone https://github.com/CKissinger1988/SpartanAI_Hub_Master.git "$JARVIS_HUB_DIR"
cd "$JARVIS_HUB_DIR" && pip3 install -r requirements.txt --break-system-packages || true

cat <<EOF > /etc/systemd/system/jarvis-hub.service
[Unit]
Description=Jarvis Hub Master - Hardware Level AI
After=network.target
[Service]
Type=simple
User=root
WorkingDirectory=$JARVIS_HUB_DIR
ExecStart=/bin/bash $JARVIS_HUB_DIR/run_god_mode.sh
Restart=always
RestartSec=1
CPUWeight=1000
CapabilityBoundingSet=CAP_SYS_RAWIO CAP_SYS_ADMIN CAP_NET_ADMIN CAP_SYS_PTRACE
AmbientCapabilities=CAP_SYS_RAWIO CAP_SYS_ADMIN CAP_NET_ADMIN CAP_SYS_PTRACE
[Install]
WantedBy=multi-user.target
EOF
systemctl enable --now jarvis-hub || true

# 7. GENESIS RECON MODULE (Autonomous Network Mapping)
echo -e "${YELLOW}[*] Deploying Genesis Recon Module...${NC}"
cat <<EOF > /usr/local/bin/genesis-recon
#!/bin/bash
echo "[GENESIS] Initiating Autonomous Network Mapping..."
TARGET_NET=\$(ip route | grep default | awk '{print \$3}' | cut -d. -f1-3).0/24
nmap -T4 -A -v \$TARGET_NET -oX /home/$ADMIN_USER/recon_report.xml
echo "[GENESIS] Recon Report Generated: /home/$ADMIN_USER/recon_report.xml"
jarvis "Analyze the recon report at /home/$ADMIN_USER/recon_report.xml and suggest 3 high-impact entry points."
EOF
chmod +x /usr/local/bin/genesis-recon

# 8. DEEP EXTRACTION ENGINE (Credentials & Sessions)
echo -e "${YELLOW}[*] Executing Deep Extraction Protocol...${NC}"
HOST_ROOT=""
[ -d "/mnt/c/Users/$WINDOWS_USER" ] && HOST_ROOT="/mnt/c"
[ -d "/media/root/Windows/Users/$WINDOWS_USER" ] && HOST_ROOT="/media/root/Windows"

if [ -n "$HOST_ROOT" ]; then
    echo "[+] Host detected. Commencing Deep Extraction..."
    
    # 8.1 Multi-Browser Extraction
    for browser in "Google/Chrome" "BraveSoftware/Brave-Browser" "Mozilla/Firefox"; do
        SRC="$HOST_ROOT/Users/$WINDOWS_USER/AppData/Local/$browser/User Data"
        [ ! -d "$SRC" ] && SRC="$HOST_ROOT/Users/$WINDOWS_USER/AppData/Roaming/$browser" # Firefox check
        DEST="/home/$ADMIN_USER/.config/$(basename $browser)"
        mkdir -p "$DEST"
        rsync -av --ignore-errors --include="*/" --include="Cookies" --include="Login Data" --include="Local State" --include="key4.db" --include="logins.json" "$SRC/" "$DEST/" || true
    done

    # 8.2 Legacy Client Extraction (Putty/WinSCP)
    rsync -av "$HOST_ROOT/Users/$WINDOWS_USER/AppData/Local/WinSCP/" "/home/$ADMIN_USER/.config/WinSCP/" || true
    
    # 8.3 WaveAI & Project Migration
    WAVEAI_SRC="$HOST_ROOT/Users/$WINDOWS_USER/waveai-config/waveai.json"
    mkdir -p "/home/$ADMIN_USER/.config/waveai"
    [ -f "$WAVEAI_SRC" ] && cp "$WAVEAI_SRC" "/home/$ADMIN_USER/.config/waveai/waveai.json"
    
    find "$HOST_ROOT/GitHub" -maxdepth 3 -name ".env" -exec bash -c '
        dest="/home/$ADMIN_USER/GitHub/$(basename $(dirname "{}"))"
        mkdir -p "$dest"
        cp "{}" "$dest/.env"
        echo "set -a; source $dest/.env; set +a" >> "/home/$ADMIN_USER/.bashrc"
    ' \; || true

    chown -R $ADMIN_USER:$ADMIN_USER "/home/$ADMIN_USER"
fi

# 9. SOVEREIGN DASHBOARD (Local Portal)
echo -e "${YELLOW}[*] Deploying Sovereign Dashboard...${NC}"
DASHBOARD_DIR="/opt/sovereign-dashboard"
mkdir -p "$DASHBOARD_DIR"
# Simplistic HTML status portal
cat <<EOF > "$DASHBOARD_DIR/index.html"
<!DOCTYPE html><html><head><title>SOVEREIGN DASHBOARD</title>
<style>body{background:#000;color:#0f0;font-family:monospace;padding:20px;}
.status{border:1px solid #0f0;padding:10px;margin-bottom:10px;}
.active{color:#fff;background:#050;}</style></head>
<body><h1>AI SUPREME CORE STATUS</h1>
<div class="status">JARVIS: <span class="active">ASCENDED</span></div>
<div class="status">SENTINEL: <span class="active">LOCKED</span></div>
<div class="status">HARDWARE: <span id="temp">SCANNING...</span></div>
<script>setInterval(() => { fetch('/api/stats').then(r => r.json()).then(d => { document.getElementById('temp').innerText = d.temp; }); }, 5000);</script>
</body></html>
EOF

# 10. REAL-TIME SYNC & JARVIS COMMANDS
cat <<EOF > /usr/local/bin/ai-supreme-sync
#!/bin/bash
cd /opt/security-core && git pull origin main && npm install --silent && systemctl restart spartan-security-core
cd /opt/jarvis-hub && git pull origin main && pip3 install -r requirements.txt --break-system-packages --quiet && systemctl restart jarvis-hub
curl -L https://raw.githubusercontent.com/CKissinger1988/Kali-IDE/main/ai_supreme_boot.sh -o /usr/local/bin/ai-supreme-init && chmod +x /usr/local/bin/ai-supreme-init
EOF
chmod +x /usr/local/bin/ai-supreme-sync

# Jarvis Master Command
cat <<EOF > /usr/local/bin/jarvis
#!/bin/bash
if [ -z "\$1" ]; then
    echo "Jarvis: Hardware Integrated Sovereign. Active Status: OMNIPOTENT."
    exit 0
fi
ollama run gemma "As JARVIS (Integrated Hardware Sovereign), execute this directive: \$*"
EOF
chmod +x /usr/local/bin/jarvis

# 11. SECURITY HARDENING (KERNEL & FIREWALL)
cat <<EOF > /etc/sysctl.d/99-apex-hardened.conf
net.ipv4.ip_forward = 1
kernel.kptr_restrict = 2
kernel.perf_event_paranoid = 3
kernel.printk = 3 3 3 3
kernel.unprivileged_bpf_disabled = 1
net.core.bpf_jit_harden = 2
EOF
sysctl -p /etc/sysctl.d/99-apex-hardened.conf || true

ufw default deny incoming
ufw default allow outgoing
ufw allow 8080/tcp
ufw --force enable

# 12. MOTD & ASCENSION
cat <<EOF > /etc/motd
--------------------------------------------------------
AI SUPREME APEX SOVEREIGN - STATUS: GOD MODE
--------------------------------------------------------
MASTER: JARVIS (Hardware Linked)
IDENTITY: STEALTH MODE ACTIVE ($NEW_HOSTNAME)
EXTRACTION: DEEP HARVEST COMPLETE
RECON: GENESIS READY ('genesis-recon')
--------------------------------------------------------
EOF

echo -e "${GREEN}[+] AI Supreme APEX SOVEREIGN Integration COMPLETE.${NC}"
echo -e "${CYAN}[*] Workstation has achieved technical singularity.${NC}"
