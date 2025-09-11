#!/bin/bash

# Check if Plymouth is available before proceeding
if ! command -v plymouth >/dev/null 2>&1 && ! dpkg -l | grep -q plymouth; then
    echo "Plymouth not installed, skipping bootloader configuration"
    exit 0
fi

if [ -d "/boot/loader/entries" ]; then # systemd-boot
  for entry in /boot/loader/entries/*.conf; do
    if [ -f "$entry" ]; then
      # Skip fallback entries
      if [[ "$(basename "$entry")" == *"fallback"* ]]; then
        continue
      fi

      # Skip if splash is already present
      if ! grep -q "splash" "$entry"; then
        sudo sed -i '/^options/ s/$/ splash quiet/' "$entry"
      fi
    fi
  done
elif [ -f "/etc/default/grub" ]; then # GRUB (standard on Debian)
  # Backup GRUB config before modifying
  backup_timestamp=$(date +"%Y%m%d%H%M%S")
  sudo cp /etc/default/grub "/etc/default/grub.bak.${backup_timestamp}"

  # Check if splash is already in GRUB_CMDLINE_LINUX_DEFAULT
  if ! grep -q "GRUB_CMDLINE_LINUX_DEFAULT.*splash" /etc/default/grub; then
    # Get current GRUB_CMDLINE_LINUX_DEFAULT value
    current_cmdline=$(grep "^GRUB_CMDLINE_LINUX_DEFAULT=" /etc/default/grub | cut -d'"' -f2)

    # Add splash and quiet if not present
    new_cmdline="$current_cmdline"
    if [[ ! "$current_cmdline" =~ splash ]]; then
      new_cmdline="$new_cmdline splash"
    fi
    if [[ ! "$current_cmdline" =~ quiet ]]; then
      new_cmdline="$new_cmdline quiet"
    fi

    # Trim any leading/trailing spaces
    new_cmdline=$(echo "$new_cmdline" | xargs)

    sudo sed -i "s/^GRUB_CMDLINE_LINUX_DEFAULT=\".*\"/GRUB_CMDLINE_LINUX_DEFAULT=\"$new_cmdline\"/" /etc/default/grub

    # Update GRUB configuration
    if command -v update-grub2 >/dev/null 2>&1; then
      sudo update-grub2 >/dev/null 2>&1
    elif command -v grub-mkconfig >/dev/null 2>&1; then
      sudo grub-mkconfig -o /boot/grub/grub.cfg >/dev/null 2>&1
    else
      echo "Error: No GRUB update command found"
      exit 1
    fi
  fi
elif [ -d "/etc/cmdline.d" ]; then # UKI
  if ! grep -q splash /etc/cmdline.d/*.conf 2>/dev/null; then
    echo "splash" | sudo tee -a /etc/cmdline.d/omakub.conf >/dev/null
  fi
  if ! grep -q quiet /etc/cmdline.d/*.conf 2>/dev/null; then
    echo "quiet" | sudo tee -a /etc/cmdline.d/omakub.conf >/dev/null
  fi
elif [ -f "/etc/kernel/cmdline" ]; then # UKI Alternate
  # Backup kernel cmdline config before modifying
  backup_timestamp=$(date +"%Y%m%d%H%M%S")
  sudo cp /etc/kernel/cmdline "/etc/kernel/cmdline.bak.${backup_timestamp}"

  current_cmdline=$(cat /etc/kernel/cmdline)

  # Add splash and quiet if not present
  new_cmdline="$current_cmdline"
  if [[ ! "$current_cmdline" =~ splash ]]; then
    new_cmdline="$new_cmdline splash"
  fi
  if [[ ! "$current_cmdline" =~ quiet ]]; then
    new_cmdline="$new_cmdline quiet"
  fi

  # Trim any leading/trailing spaces
  new_cmdline=$(echo "$new_cmdline" | xargs)

  # Write new file
  echo "$new_cmdline" | sudo tee /etc/kernel/cmdline >/dev/null
else
  echo "No supported bootloader detected. Please manually add 'splash quiet' kernel parameters."
fi