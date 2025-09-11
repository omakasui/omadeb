#!/bin/bash

# ==============================================================================
# PLYMOUTH SETUP
# ==============================================================================

# Set theme only if different
current_theme=$(plymouth-set-default-theme 2>/dev/null || echo "")
if [ "$current_theme" != "omakub" ]; then
    sudo cp -r "$HOME/.local/share/omakub/default/plymouth" /usr/share/plymouth/themes/omakub/ >/dev/null 2>&1

    if sudo plymouth-set-default-theme omakub >/dev/null 2>&1; then
        # Update initramfs after setting theme
        sudo update-initramfs -u >/dev/null 2>&1
    fi
fi

# Configure systemd service
if [ ! -f /etc/systemd/system/plymouth-quit.service.d/wait-for-graphical.conf ]; then
    sudo mkdir -p /etc/systemd/system/plymouth-quit.service.d
    sudo tee /etc/systemd/system/plymouth-quit.service.d/wait-for-graphical.conf >/dev/null <<'EOF'
[Unit]
After=multi-user.target
EOF
fi

# Mask service if not already masked
if ! systemctl is-enabled plymouth-quit-wait.service 2>/dev/null | grep -q masked; then
    sudo systemctl mask plymouth-quit-wait.service >/dev/null 2>&1
    sudo systemctl daemon-reload >/dev/null 2>&1
fi