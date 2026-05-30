#!/bin/bash
# =========================================================================
#  AI SUPREME - PERSISTENT INTEGRATION ENGINE (FIRST-BOOT EDITION)
# =========================================================================
# MANDATE: Absolute Sovereignty, AI-Driven Administration, and Offensive Readiness
# USER: Creator / @11646 (Passwordless Sudo)

set -e

GREEN='\033[0;32m'
CYAN='\033[0;36m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

# User Credentials
ADMIN_USER="Creator"
ADMIN_PASS="@11646"

echo -e "${CYAN}[*] Initiating AI Supreme Persistent Integration...${NC}"

# 1. Root Check
if [ "$EUID" -ne 0 ]; then
    echo -e "${RED}[!] Error: This script must be run as root (sudo).${NC}"
    exit 1
fi

# 2. User Setup
echo -e "${YELLOW}[*] Configuring Sovereign User: $ADMIN_USER...${NC}"
if ! id "$ADMIN_USER" &>/dev/null; then
    useradd -m -s /bin/bash -G sudo,video,render "$ADMIN_USER"
fi
echo "$ADMIN_USER:$ADMIN_PASS" | chpasswd

# 3. Passwordless Sudo
echo -e "${YELLOW}[*] Unlocking Sudo Constraints...${NC}"
echo "$ADMIN_USER ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/99-ai-supreme
chmod 0440 /etc/sudoers.d/99-ai-supreme

# 4. Dependency Provisioning
echo -e "${YELLOW}[*] Provisioning Core Dependencies...${NC}"
apt-get update
apt-get install -y curl wget git nodejs npm python3-pip python3-venv libfuse2t64 desktop-file-utils firefox-esr sudo

# 5. OLLAMA & GEMMA
echo -e "${YELLOW}[*] Deploying Ollama & Gemma (System AI)...${NC}"
if ! command -v ollama >/dev/null; then
    curl -fsSL https://ollama.com/install.sh | sh
fi

# Service setup
cat <<EOF > /etc/systemd/system/ollama.service
[Unit]
Description=Ollama Service
After=network-online.target

[Service]
ExecStart=/usr/local/bin/ollama serve
User=root
Group=root
Restart=always
RestartSec=3

[Install]
WantedBy=multi-user.target
EOF
systemctl daemon-reload
systemctl enable --now ollama

# Model Pull
echo "[*] Pulling Gemma model (This may take a moment)..."
ollama pull gemma

# 6. GEMINI-CLI
echo -e "${YELLOW}[*] Deploying Gemini-CLI...${NC}"
npm install -g @google/gemini-cli --unsafe-perm

# 7. ANTIGRAVITY-CLI
echo -e "${YELLOW}[*] Deploying Antigravity-CLI (agy)...${NC}"
curl -fsSL https://antigravity.google/cli/install.sh | bash || echo "[!] Official agy install failed."

# 8. HEXSTRIKE-AI
echo -e "${YELLOW}[*] Deploying HexStrike-AI...${NC}"
rm -rf /opt/hexstrike-ai
git clone https://github.com/CKissinger1988/HexStrike-AI.git /opt/hexstrike-ai
cd /opt/hexstrike-ai && pip3 install -r requirements.txt --break-system-packages || true

# 9. LM STUDIO
echo -e "${YELLOW}[*] Deploying LM Studio...${NC}"
mkdir -p /usr/local/bin
wget -O /usr/local/bin/lm-studio.AppImage https://releases.lmstudio.ai/linux/x64/latest/LM_Studio-latest.AppImage
chmod +x /usr/local/bin/lm-studio.AppImage

# 10. ANTIGRAVITY IDE (CODE-SERVER)
echo -e "${YELLOW}[*] Deploying Antigravity IDE...${NC}"
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
systemctl enable --now antigravity-ide

# 11. Sovereign Shell Configuration
cat <<EOF > /usr/share/applications/antigravity-2.0.desktop
[Desktop Entry]
Name=Antigravity 2.0
Exec=/usr/bin/firefox http://localhost:8080
Icon=utilities-terminal
Type=Application
Categories=Development;Security;
EOF

# 12. AI Administrator Integration
echo -e "${YELLOW}[*] Linking Sovereign AI Core...${NC}"

# Jarvis Command
cat <<EOF > /usr/local/bin/jarvis
#!/bin/bash
if [ -z "\$1" ]; then
    echo "Jarvis (Gemma): Awaiting orders..."
    exit 0
fi
ollama run gemma "\$*"
EOF
chmod +x /usr/local/bin/jarvis

# AI-Admin Command
cat <<EOF > /usr/local/bin/ai-admin
#!/bin/bash
ACTION="\$*"
echo "[AI-ADMIN] Consultative Action: \$ACTION"
REASONING=\$(jarvis "Should I execute '\$ACTION' on this Kali system? Provide a yes/no and brief risk assessment.")
echo "\$REASONING"
if [[ "\$REASONING" == *"yes"* ]] || [[ "\$REASONING" == *"Yes"* ]]; then
    sudo \$ACTION
else
    echo "[AI-ADMIN] Action aborted based on Gemma risk assessment."
fi
EOF
chmod +x /usr/local/bin/ai-admin

# MOTD
echo "--------------------------------------------------------" > /etc/motd
echo "AI SUPREME PERSISTENT CORE - ONLINE" >> /etc/motd
echo "User: $ADMIN_USER (Sovereign Administrator)" >> /etc/motd
echo "Administrator: Gemma (via 'jarvis')" >> /etc/motd
echo "--------------------------------------------------------" >> /etc/motd

echo -e "${GREEN}[+] AI Supreme Integration COMPLETE.${NC}"
echo -e "${CYAN}[*] Please log in as '$ADMIN_USER' and enjoy total autonomy.${NC}"
