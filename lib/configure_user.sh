#!/bin/bash
# lib/configure_user.sh - Configures user and security settings

function configure_user() {
    local admin_user=$1
    local admin_pass=$2
    echo "[+] Creating admin user: $admin_user"
    if ! id "$admin_user" &>/dev/null; then
        useradd -m -s /bin/bash -G sudo,video,render "$admin_user"
    fi
    echo "$admin_user:$admin_pass" | chpasswd
    
    # Passwordless sudo
    echo "[+] Enabling passwordless sudo for $admin_user"
    echo "$admin_user ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/99-ai-supreme
    chmod 0440 /etc/sudoers.d/99-ai-supreme
}
