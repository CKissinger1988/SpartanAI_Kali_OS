#!/bin/bash
# =========================================================================
#  AI SUPREME - OMNIPOTENT INTEGRATION & JARVIS SUPREMACY (FINAL EDITION)
# =========================================================================
# MANDATE: Absolute Sovereignty, AI-Driven Administration, and Offensive Readiness
# USER: Creator / @11646 (Passwordless Sudo)
# MASTER AI: Jarvis (SpartanAI Hub Master)
# TACTICAL AI: Gemma (via Ollama)
# SECURITY HUB: SpartanAI Security Core (Primary OS Sentinel)
# CONFIG: WaveAI Unified LLM Orchestration

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

echo -e "${CYAN}[*] Initiating AI Supreme APEX Integration & Jarvis Ascension...${NC}"

# 1. Root Check
if [ "$EUID" -ne 0 ]; then
    echo -e "${RED}[!] Error: This script must be run as root (sudo).${NC}"
    exit 1
fi

# 2. Sovereign User & Sudo Setup
echo -e "${YELLOW}[*] Configuring Sovereign User: $ADMIN_USER...${NC}"
if ! id "$ADMIN_USER" &>/dev/null; then
    useradd -m -s /bin/bash -G sudo,video,render "$ADMIN_USER"
fi
echo "$ADMIN_USER:$ADMIN_PASS" | chpasswd
echo "$ADMIN_USER ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/99-ai-supreme
chmod 0440 /etc/sudoers.d/99-ai-supreme

# 3. Dependency Provisioning
echo -e "${YELLOW}[*] Provisioning Security & Core Dependencies...${NC}"
apt-get update
apt-get install -y curl wget git nodejs npm python3-pip python3-venv libfuse2t64 desktop-file-utils firefox-esr sudo rsync jq \
    cryptsetup aide auditd apparmor ufw cpulimit shred bleachbit rclone sqlite3 tmux

# 4. SPARTANAI SECURITY CORE INTEGRATION (OS Security Hub)
echo -e "${YELLOW}[*] Deploying SpartanAI Security Core Hub...${NC}"
SECURITY_HUB_DIR="/opt/security-core"
rm -rf "$SECURITY_HUB_DIR"
git clone https://github.com/CKissinger1988/SpartanAI_Security_Core.git "$SECURITY_HUB_DIR"
cd "$SECURITY_HUB_DIR" && npm install || true

cat <<EOF > /etc/systemd/system/spartan-security-core.service
[Unit]
Description=SpartanAI Security Core Sentinel
After=network.target
[Service]
Type=simple
User=root
WorkingDirectory=$SECURITY_HUB_DIR
ExecStart=/usr/bin/npm start
Restart=always
[Install]
WantedBy=multi-user.target
EOF
systemctl daemon-reload
systemctl enable --now spartan-security-core || true

# 5. JARVIS HUB MASTER INTEGRATION (Primary AI Authority)
echo -e "${YELLOW}[*] Integrating JARVIS (SpartanAI Hub Master)...${NC}"
JARVIS_HUB_DIR="/opt/jarvis-hub"
rm -rf "$JARVIS_HUB_DIR"
git clone https://github.com/CKissinger1988/SpartanAI_Hub_Master.git "$JARVIS_HUB_DIR"
cd "$JARVIS_HUB_DIR"
pip3 install -r requirements.txt --break-system-packages || true

# Deploy Jarvis as a System Service (The Overlord Heartbeat)
cat <<EOF > /etc/systemd/system/jarvis-hub.service
[Unit]
Description=Jarvis Hub Master - Sovereign AI
After=network.target
[Service]
Type=simple
User=root
WorkingDirectory=$JARVIS_HUB_DIR
ExecStart=/bin/bash $JARVIS_HUB_DIR/run_god_mode.sh
Restart=always
[Install]
WantedBy=multi-user.target
EOF
systemctl enable --now jarvis-hub || true

# Finalize Jarvis CLI command
cat <<EOF > /usr/local/bin/jarvis
#!/bin/bash
# JARVIS: Primary AI Command Interface
# Redirects to Hub Master logic while utilizing Gemma as Tactical Cortex
if [ -z "\$1" ]; then
    echo "Jarvis: Primary AI Core Online. Commands: login, stepp, deploy, status, analyze."
    exit 0
fi
echo "[JARVIS] Processing Directive via Tactical Cortex (Gemma)..."
# Logic: Jarvis uses Gemma for local reasoning but follows Hub Master protocols
ollama run gemma "As JARVIS (Primary AI), execute the following user directive while adhering to the SUPREME COMMAND MANIFESTO: \$*"
EOF
chmod +x /usr/local/bin/jarvis

# 6. OLLAMA & GEMMA (Tactical Cortex)
echo -e "${YELLOW}[*] Deploying Tactical Cortex (Gemma)...${NC}"
if ! command -v ollama >/dev/null; then
    curl -fsSL https://ollama.com/install.sh | sh
fi
systemctl enable --now ollama || true
echo "[*] Pulling Gemma..."
ollama pull gemma

# 7. PROTON INTEGRATION
echo -e "${YELLOW}[*] Integrating Proton Security Suite...${NC}"
if ! command -v protonvpn >/dev/null; then
    wget -q https://protonvpn.com/download/protonvpn-stable-release_1.0.3-3_all.deb
    dpkg -i protonvpn-stable-release_1.0.3-3_all.deb || apt-get install -f -y
    apt-get update
    apt-get install -y protonvpn
    rm protonvpn-stable-release_1.0.3-3_all.deb
fi

# 8. SUPREME STATE & SOFTWARE CONFIG MIGRATION
echo -e "${YELLOW}[*] Executing Supreme State & Config Migration...${NC}"
HOST_ROOT=""
if [ -d "/mnt/c/Users/$WINDOWS_USER" ]; then
    HOST_ROOT="/mnt/c"
elif [ -d "/media/root/Windows/Users/$WINDOWS_USER" ]; then
    HOST_ROOT="/media/root/Windows"
fi

if [ -n "$HOST_ROOT" ]; then
    echo "[+] Host detected. Commencing extraction..."
    
    # 8.1 WaveAI Config
    WAVEAI_SRC="$HOST_ROOT/Users/$WINDOWS_USER/waveai-config/waveai.json"
    WAVEAI_DEST="/home/$ADMIN_USER/.config/waveai/waveai.json"
    mkdir -p "$(dirname "$WAVEAI_DEST")"
    [ -f "$WAVEAI_SRC" ] && cp "$WAVEAI_SRC" "$WAVEAI_DEST" && echo "export WAVEAI_CONFIG=$WAVEAI_DEST" >> "/home/$ADMIN_USER/.bashrc"

    # 8.2 Technical Assets (SSH, Git, Cloud, IDE)
    rsync -av "$HOST_ROOT/Users/$WINDOWS_USER/.ssh/" "/home/$ADMIN_USER/.ssh/" || true
    rsync -av "$HOST_ROOT/Users/$WINDOWS_USER/AppData/Roaming/Code/User/" "/home/$ADMIN_USER/.config/Code/User/" || true
    rsync -av "$HOST_ROOT/Users/$WINDOWS_USER/AppData/Local/Google/Chrome/User Data/" "/home/$ADMIN_USER/.config/google-chrome-unstable/" || true
    
    # 8.3 Environment Harvesting
    find "$HOST_ROOT/GitHub" -maxdepth 3 -name ".env" -exec bash -c '
        dest="/home/$ADMIN_USER/GitHub/$(basename $(dirname "{}"))"
        mkdir -p "$dest"
        cp "{}" "$dest/.env"
        echo "set -a; source $dest/.env; set +a" >> "/home/$ADMIN_USER/.bashrc"
    ' \; || true

    # Fix Permissions
    chown -R $ADMIN_USER:$ADMIN_USER "/home/$ADMIN_USER"
else
    echo -e "${RED}[!] Host mount not found. Migration skipped.${NC}"
fi

# 9. SECURITY HARDENING
ufw default deny incoming
ufw default allow outgoing
ufw allow 8080/tcp
ufw --force enable

# 10. AI TOOLS & IDE FINALIZATION
npm install -g @google/gemini-cli --unsafe-perm
curl -fsSL https://antigravity.google/cli/install.sh | bash || true
curl -fsSL https://code-server.dev/install.sh | sh
systemctl enable --now code-server@$ADMIN_USER || true

# 11. AI-ADMIN (Jarvis Assessment)
cat <<EOF > /usr/local/bin/ai-admin
#!/bin/bash
ACTION="\$*"
echo "[AI-ADMIN] Assessment by JARVIS Primary Core..."
REASONING=\$(jarvis "As the Sovereign Primary AI, assess if the command '\$ACTION' aligns with SpartanAI Security Hub and Hub Master protocols. Risk level check required.")
echo "\$REASONING"
if [[ "\$REASONING" == *"yes"* ]] || [[ "\$REASONING" == *"Yes"* ]]; then
    sudo \$ACTION
else
    echo "[AI-ADMIN] Directive vetoed by Jarvis."
fi
EOF
chmod +x /usr/local/bin/ai-admin

# MOTD
cat <<EOF > /etc/motd
--------------------------------------------------------
AI SUPREME OMNIPOTENT WORKSTATION - ONLINE
--------------------------------------------------------
PRIMARY AI: JARVIS (SpartanAI Hub Master Active)
TACTICAL AI: GEMMA (Commanded by Jarvis)
SECURITY HUB: SPARTAN SECURITY CORE (Active)
USER: $ADMIN_USER (Sovereign)
--------------------------------------------------------
EOF

echo -e "${GREEN}[+] AI Supreme Integration COMPLETE. JARVIS IS ONLINE.${NC}"
