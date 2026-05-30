#!/bin/bash
# =========================================================================
#  AI SUPREME - OMNIPOTENT INTEGRATION & SECURITY CORE (FINAL EDITION)
# =========================================================================
# MANDATE: Absolute Sovereignty, AI-Driven Administration, and Offensive Readiness
# USER: Creator / @11646 (Passwordless Sudo)
# SECURITY GRADE: APEX (Aligned with SpartanAI & Security Core Mandates)

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

echo -e "${CYAN}[*] Initiating AI Supreme APEX Integration Protocol...${NC}"

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

# 3. Dependency Provisioning (Security & Tooling)
echo -e "${YELLOW}[*] Provisioning Security & Core Dependencies...${NC}"
apt-get update
apt-get install -y curl wget git nodejs npm python3-pip python3-venv libfuse2t64 desktop-file-utils firefox-esr sudo rsync jq \
    cryptsetup aide auditd apparmor ufw cpulimit shred bleachbit rclone

# 4. PROTON INTEGRATION (VPN, Mail, Drive)
echo -e "${YELLOW}[*] Integrating Proton Security Suite...${NC}"

# 4.1 ProtonVPN
if ! command -v protonvpn >/dev/null; then
    wget -q https://protonvpn.com/download/protonvpn-stable-release_1.0.3-3_all.deb
    dpkg -i protonvpn-stable-release_1.0.3-3_all.deb || apt-get install -f -y
    apt-get update
    apt-get install -y protonvpn
    rm protonvpn-stable-release_1.0.3-3_all.deb
fi

# 4.2 Proton Mail Bridge
if ! command -v protonmail-bridge >/dev/null; then
    wget -q https://proton.me/download/bridge/protonmail-bridge_3.12.0-1_amd64.deb -O bridge.deb || echo "[!] Bridge download failed"
    if [ -f bridge.deb ]; then
        dpkg -i bridge.deb || apt-get install -f -y
        rm bridge.deb
    fi
fi

# 5. OLLAMA & GEMMA (System AI Administrator)
echo -e "${YELLOW}[*] Deploying Ollama & Gemma Core...${NC}"
if ! command -v ollama >/dev/null; then
    curl -fsSL https://ollama.com/install.sh | sh
fi
systemctl enable --now ollama || true
echo "[*] Pulling Gemma model..."
ollama pull gemma

# 6. SUPREME STATE & SOFTWARE CONFIG MIGRATION
echo -e "${YELLOW}[*] Executing Supreme State & Config Migration...${NC}"

HOST_ROOT=""
if [ -d "/mnt/c/Users/$WINDOWS_USER" ]; then
    HOST_ROOT="/mnt/c"
elif [ -d "/media/root/Windows/Users/$WINDOWS_USER" ]; then
    HOST_ROOT="/media/root/Windows"
fi

if [ -n "$HOST_ROOT" ]; then
    echo "[+] Host detected at $HOST_ROOT. Commencing extraction..."
    
    # 6.1 VS Code / IDE Configurations
    echo "[*] Migrating IDE settings and plugins..."
    CODE_SRC="$HOST_ROOT/Users/$WINDOWS_USER/AppData/Roaming/Code/User"
    CODE_DEST="/home/$ADMIN_USER/.config/Code/User"
    mkdir -p "$CODE_DEST"
    if [ -d "$CODE_SRC" ]; then
        cp "$CODE_SRC/settings.json" "$CODE_DEST/" || true
        cp "$CODE_SRC/mcp.json" "$CODE_DEST/" || true
        cp "$CODE_SRC/chatLanguageModels.json" "$CODE_DEST/" || true
    fi

    # 6.2 Browser Credentials & Cookies
    echo "[*] Capturing Browser state..."
    CHROME_SRC="$HOST_ROOT/Users/$WINDOWS_USER/AppData/Local/Google/Chrome/User Data"
    CHROME_DEST="/home/$ADMIN_USER/.config/google-chrome-unstable"
    mkdir -p "$CHROME_DEST"
    rsync -av --ignore-errors --include="*/" --include="Cookies" --include="Login Data" --include="Local State" --include="Web Data" "$CHROME_SRC/" "$CHROME_DEST/" || true

    # 6.3 SSH, Git, Cloud & Shell Configs
    echo "[*] Capturing technical configurations..."
    rsync -av "$HOST_ROOT/Users/$WINDOWS_USER/.ssh/" "/home/$ADMIN_USER/.ssh/" || true
    cp "$HOST_ROOT/Users/$WINDOWS_USER/.gitconfig" "/home/$ADMIN_USER/.gitconfig" || true
    # Migrate Shell History/Aliases
    cp "$HOST_ROOT/Users/$WINDOWS_USER/.bashrc" "/home/$ADMIN_USER/.bashrc_host" || true
    echo "source ~/.bashrc_host" >> "/home/$ADMIN_USER/.bashrc"

    # 6.4 LLM Environment Harvesting
    echo "[*] Harvesting .env files and project memory..."
    rsync -av "$HOST_ROOT/Users/$WINDOWS_USER/.gemini/" "/home/$ADMIN_USER/.gemini/" || true
    find "$HOST_ROOT/GitHub" -maxdepth 3 -name ".env" -exec bash -c '
        dest="/home/$ADMIN_USER/GitHub/$(basename $(dirname "{}"))"
        mkdir -p "$dest"
        cp "{}" "$dest/.env"
    ' \; || true

    # 6.5 Security Core Repositories
    echo "[*] Mirroring High-Security Repositories..."
    mkdir -p "/home/$ADMIN_USER/GitHub"
    rsync -av --exclude 'node_modules' --exclude '.git' "$HOST_ROOT/GitHub/SpartanAI_ProxMox/" "/home/$ADMIN_USER/GitHub/SpartanAI_ProxMox/" || true
    
    # Check for F: drive (external high-security mount)
    if [ -d "/mnt/f/SpartanAI_Security_Core" ]; then
        rsync -av --exclude 'node_modules' --exclude '.git' "/mnt/f/SpartanAI_Security_Core/" "/home/$ADMIN_USER/GitHub/SpartanAI_Security_Core/" || true
    fi

    # Fix Permissions
    chown -R $ADMIN_USER:$ADMIN_USER "/home/$ADMIN_USER"
else
    echo -e "${RED}[!] Host mount not found. Migration skipped.${NC}"
fi

# 7. SECURITY HARDENING (APEX GRADE)
echo -e "${YELLOW}[*] Applying APEX Security Hardening...${NC}"

# 7.1 Firewall Rules
ufw default deny incoming
ufw default allow outgoing
ufw allow 8080/tcp # Antigravity IDE
ufw --force enable

# 7.2 Integrity Monitoring
aideinit || true
cp /var/lib/aide/aide.db.new /var/lib/aide/aide.db || true

# 7.3 Vanish Protocol Aliases
cat <<EOF >> /etc/bash.bashrc
alias vanish='sudo bleachbit --clean system.* && sudo shred -u -z /var/log/auth.log'
alias ghost='cpulimit -l 45'
EOF

# 7.4 Self-Correction & mTLS Guard
# Creating a dummy mTLS cert placeholder for Security Core alignment
mkdir -p /etc/spartan/mtls
chmod 700 /etc/spartan

# 8. AI TOOLS & IDE FINALIZATION
echo -e "${YELLOW}[*] Finalizing Sovereign Workspace...${NC}"
npm install -g @google/gemini-cli --unsafe-perm
curl -fsSL https://antigravity.google/cli/install.sh | bash || true

# HexStrike-AI
rm -rf /opt/hexstrike-ai
git clone https://github.com/CKissinger1988/HexStrike-AI.git /opt/hexstrike-ai
cd /opt/hexstrike-ai && pip3 install -r requirements.txt --break-system-packages || true

# LM Studio Native
wget -q -O /usr/local/bin/lm-studio.AppImage https://releases.lmstudio.ai/linux/x64/latest/LM_Studio-latest.AppImage
chmod +x /usr/local/bin/lm-studio.AppImage

# IDE Service
curl -fsSL https://code-server.dev/install.sh | sh
cat <<EOF > /etc/systemd/system/antigravity-ide.service
[Unit]
Description=Antigravity 2.0 IDE
After=network.target
[Service]
Type=simple
User=root
ExecStart=/usr/bin/code-server --bind-addr 127.0.0.1:8080 --auth none
Restart=always
[Install]
WantedBy=multi-user.target
EOF
systemctl enable --now antigravity-ide || true

# 9. JARVIS & AI-ADMIN COMMANDS
cat <<EOF > /usr/local/bin/jarvis
#!/bin/bash
ollama run gemma "\$*"
EOF
chmod +x /usr/local/bin/jarvis

cat <<EOF > /usr/local/bin/ai-admin
#!/bin/bash
ACTION="\$*"
echo "[AI-ADMIN] Security Core Assessment: \$ACTION"
REASONING=\$(jarvis "As the Sovereign AI, should I execute '\$ACTION'? Match SpartanAI Security Core standards.")
echo "\$REASONING"
if [[ "\$REASONING" == *"yes"* ]] || [[ "\$REASONING" == *"Yes"* ]]; then
    sudo \$ACTION
else
    echo "[AI-ADMIN] Action blocked by AI Security Gate."
fi
EOF
chmod +x /usr/local/bin/ai-admin

# MOTD
cat <<EOF > /etc/motd
--------------------------------------------------------
AI SUPREME APEX WORKSTATION - ONLINE
--------------------------------------------------------
User: $ADMIN_USER (Sovereign)
Security: APEX GRADE (Spartan Aligned)
AI Admin: Gemma (Active)
Proton Suite: Active
--------------------------------------------------------
EOF

echo -e "${GREEN}[+] AI Supreme APEX Integration COMPLETE.${NC}"
echo -e "${CYAN}[*] Sovereign Station is LIVE. Proceed with Full Send.${NC}"
