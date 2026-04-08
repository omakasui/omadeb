echo -e "\e[32m\nRefresh Omakasui APT repository with new keyring and source list\e[0m"

if [[ -f /usr/share/keyrings/omakasui-apt.gpg ]]; then
  sudo rm -f /usr/share/keyrings/omakasui-apt.gpg
fi

if [[ -f /etc/apt/sources.list.d/omakasui.list ]]; then
  sudo rm -f /etc/apt/sources.list.d/omakasui.list
fi

curl -fsSL https://keyrings.omakasui.org/omakasui-packages.gpg.key \
  | gpg --dearmor \
  | sudo tee /usr/share/keyrings/omakasui-packages.gpg > /dev/null

echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/omakasui-packages.gpg] \
  https://packages.omakasui.org $(. /etc/os-release && echo $VERSION_CODENAME) main" \
  | sudo tee /etc/apt/sources.list.d/omakasui.list > /dev/null

sudo apt update

# Refresh Omakasui's Yaru-theme to pick up new hot-reload themes
echo -e "\e[32m\nRefresh Omakasui's Yaru-theme\e[0m"
omadeb-pkg-add omakasui-yaru-theme-gtk omakasui-yaru-theme-icon omakasui-yaru-theme-sound omakasui-yaru-theme-gnome-shell

echo -e "\e[32m\nRefresh Omakasui packages\e[0m"
# Gum
omadeb-pkg-add gum

# Lazygit, Lazydocker, Fastfetch
if omadeb-pkg-present omakasui-lazygit; then
  omadeb-pkg-drop omakasui-lazygit
fi
omadeb-pkg-add lazygit

if omadeb-pkg-present omakasui-lazydocker; then
  omadeb-pkg-drop omakasui-lazydocker
fi
omadeb-pkg-add lazydocker

sudo add-apt-repository --remove -y ppa:zhangsongcui3371/fastfetch
if omadeb-pkg-present omakasui-fastfetch; then
  omadeb-pkg-drop omakasui-fastfetch
fi
omadeb-pkg-add fastfetch

# Fonts
if omadeb-pkg-present omakasui-font-cascadia-mono-nf; then
  omadeb-pkg-drop omakasui-font-cascadia-mono-nf
  omadeb-pkg-add font-cascadia-mono-nf
fi

if omadeb-pkg-present omakasui-font-jetbrains-mono; then
  omadeb-pkg-drop omakasui-font-jetbrains-mono
  omadeb-pkg-add font-jetbrains-mono
fi

if omadeb-pkg-present omakasui-ia-writer-mono; then
  omadeb-pkg-drop omakasui-ia-writer-mono
  omadeb-pkg-add font-ia-writer-mono
fi

# NVim
echo -e "\e[32m\nChange to omadeb-nvim package\e[0m"
if omadeb-pkg-present omadeb-nvim; then
  omadeb-pkg-add omadeb-nvim
else
  omadeb-pkg-add omadeb-nvim
  # Will trigger to overwrite configs or not to pickup new hot-reload themes
  omadeb-setup-nvim
fi

# Nautilus
echo -e "\e[32m\nNautilus now handles all terminals...\e[0m"
if omadeb-pkg-present nautilus-extension-gnome-terminal; then
    omadeb-pkg-drop nautilus-extension-gnome-terminal
fi

if omadeb-pkg-present omakasui-nautilus-open-any-terminal; then
    omadeb-pkg-drop omakasui-nautilus-open-any-terminal
fi
omadeb-pkg-add nautilus-open-any-terminal

# Set the default terminal for the nautilus-open-any-terminal extension
DEFAULT_TERMINAL=$(omadeb-terminal-current)
DEFAULT_TERMINAL=${DEFAULT_TERMINAL,,}

gsettings set com.github.stunkymonkey.nautilus-open-any-terminal terminal "${DEFAULT_TERMINAL}"
gsettings set com.github.stunkymonkey.nautilus-open-any-terminal keybindings '<Ctrl><Alt>t'
gsettings set com.github.stunkymonkey.nautilus-open-any-terminal new-tab true
gsettings set com.github.stunkymonkey.nautilus-open-any-terminal flatpak system


