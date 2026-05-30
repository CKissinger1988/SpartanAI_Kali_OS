#!/bin/bash
# =========================================================================
#  AI SUPREME - PERSISTENT INTEGRATION ENGINE (FIRST-BOOT EDITION)
# =========================================================================
# MANDATE: Absolute Sovereignty, AI-Driven Administration, and Offensive Readiness
# USER: Creator / @11646 (Passwordless Sudo)
# FEATURES: Chrome-Dev, Credential Capture, LLM Env Migration, AI Core integration

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

echo -e "${CYAN}[*] Initiating AI Supreme Persistent Integration & State Capture...${NC}"

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
echo -e "${YELLOW}[*] Provisioning Core Dependencies...${NC}"
apt-get update
apt-get install -y curl wget git nodejs npm python3-pip python3-venv libfuse2t64 desktop-file-utils firefox-esr sudo rsync jq

# 4. OLLAMA & GEMMA
echo -e "${YELLOW}[*] Deploying Ollama & Gemma (System AI)...${NC}"
if ! command -v ollama >/dev/null; then
    curl -fsSL https://ollama.com/install.sh | sh
fi
systemctl enable --now ollama || true
echo "[*] Pulling Gemma model..."
ollama pull gemma

# 5. GOOGLE CHROME DEV
echo -e "${YELLOW}[*] Deploying Google Chrome Dev...${NC}"
if ! command -v google-chrome-unstable >/dev/null; then
    wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | gpg --dearmor -o /usr/share/keyrings/google-chrome.gpg
    echo "deb [arch=amd64 signed-by=/usr/share/keyrings/google-chrome.gpg] http://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google-chrome.list
    apt-get update
    apt-get install -y google-chrome-unstable
fi

# 6. SUPREME STATE CAPTURE (Credentials & LLM Envs)
echo -e "${YELLOW}[*] Executing Supreme State Capture Protocol...${NC}"

HOST_ROOT=""
if [ -d "/mnt/c/Users/$WINDOWS_USER" ]; then
    HOST_ROOT="/mnt/c"
elif [ -d "/media/root/Windows/Users/$WINDOWS_USER" ]; then
    HOST_ROOT="/media/root/Windows"
fi

if [ -n "$HOST_ROOT" ]; then
    echo "[+] Host detected at $HOST_ROOT. Commencing extraction..."
    
    # 6.1 Browser Credentials & Cookies
    echo "[*] Capturing Browser state (Cookies/Logins)..."
    CHROME_SRC="$HOST_ROOT/Users/$WINDOWS_USER/AppData/Local/Google/Chrome/User Data"
    CHROME_DEST="/home/$ADMIN_USER/.config/google-chrome-unstable"
    mkdir -p "$CHROME_DEST"
    # Sync with focus on local state files
    rsync -av --ignore-errors --include="*/" --include="Cookies" --include="Login Data" --include="Local State" --include="Web Data" "$CHROME_SRC/" "$CHROME_DEST/" || true

    # 6.2 SSH & Git Credentials
    echo "[*] Capturing SSH keys and Git configurations..."
    rsync -av "$HOST_ROOT/Users/$WINDOWS_USER/.ssh/" "/home/$ADMIN_USER/.ssh/" || true
    cp "$HOST_ROOT/Users/$WINDOWS_USER/.gitconfig" "/home/$ADMIN_USER/.gitconfig" || true
    chmod 700 "/home/$ADMIN_USER/.ssh"
    chmod 600 "/home/$ADMIN_USER/.ssh/"* || true

    # 6.3 Cloud Provider Credentials
    echo "[*] Capturing Cloud CLI credentials (AWS/GCP/Azure)..."
    rsync -av "$HOST_ROOT/Users/$WINDOWS_USER/.aws/" "/home/$ADMIN_USER/.aws/" || true
    rsync -av "$HOST_ROOT/Users/$WINDOWS_USER/.azure/" "/home/$ADMIN_USER/.azure/" || true
    rsync -av "$HOST_ROOT/Users/$WINDOWS_USER/.config/gcloud/" "/home/$ADMIN_USER/.config/gcloud/" || true

    # 6.4 LLM Environment & Project State
    echo "[*] Harvesting LLM Environment files (.env) and project memory..."
    
    # Global AI Memory
    rsync -av "$HOST_ROOT/Users/$WINDOWS_USER/.gemini/" "/home/$ADMIN_USER/.gemini/" || true
    
    # Recursive search for .env files in GitHub directory
    find "$HOST_ROOT/GitHub" -maxdepth 3 -name ".env" -exec bash -c '
        dest="/home/$ADMIN_USER/GitHub/$(basename $(dirname "{}"))"
        mkdir -p "$dest"
        cp "{}" "$dest/.env"
    ' \; || true

    # Project Shard: SpartanAI_ProxMox
    PROJECT_SRC="$HOST_ROOT/GitHub/SpartanAI_ProxMox"
    if [ -d "$PROJECT_SRC" ]; then
        mkdir -p "/home/$ADMIN_USER/GitHub/SpartanAI_ProxMox"
        rsync -av --exclude 'node_modules' --exclude '.git' "$PROJECT_SRC/" "/home/$ADMIN_USER/GitHub/SpartanAI_ProxMox/"
    fi

    # 6.5 LM Studio State
    echo "[*] Migrating LM Studio configuration..."
    rsync -av "$HOST_ROOT/Users/$WINDOWS_USER/AppData/Roaming/LM Studio/" "/home/$ADMIN_USER/.config/LM Studio/" || true

    # Fix Permissions
    chown -R $ADMIN_USER:$ADMIN_USER "/home/$ADMIN_USER"
else
    echo -e "${RED}[!] Host mount not found. Manual extraction required.${NC}"
fi

# 7. AI TOOLS INTEGRATION (Final Layer)
echo -e "${YELLOW}[*] Finalizing AI Toolchain...${NC}"
npm install -g @google/gemini-cli --unsafe-perm
curl -fsSL https://antigravity.google/cli/install.sh | bash || true

# HexStrike-AI
rm -rf /opt/hexstrike-ai
git clone https://github.com/CKissinger1988/HexStrike-AI.git /opt/hexstrike-ai
cd /opt/hexstrike-ai && pip3 install -r requirements.txt --break-system-packages || true

# LM Studio Native
wget -q -O /usr/local/bin/lm-studio.AppImage https://releases.lmstudio.ai/linux/x64/latest/LM_Studio-latest.AppImage
chmod +x /usr/local/bin/lm-studio.AppImage

# 8. IDE & COMMANDS
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

# Jarvis Link
cat <<EOF > /usr/local/bin/jarvis
#!/bin/bash
ollama run gemma "\$*"
EOF
chmod +x /usr/local/bin/jarvis

# MOTD
echo "--------------------------------------------------------" > /etc/motd
echo "AI SUPREME OMNIPOTENT WORKSTATION" >> /etc/motd
echo "Status: ALL CREDENTIALS AND LLM STATES CAPTURED" >> /etc/motd
echo "User: $ADMIN_USER" >> /etc/motd
echo "--------------------------------------------------------" >> /etc/motd

echo -e "${GREEN}[+] State Capture & Integration COMPLETE.${NC}"
echo -e "${CYAN}[*] Sovereign link established. Resume workflow immediately.${NC}"
