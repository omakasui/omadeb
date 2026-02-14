#!/bin/bash

# Alt+F4 is very cumbersome
gsettings set org.gnome.desktop.wm.keybindings close "['<Super>w']"

# Make it easy to maximize like you can fill left/right
gsettings set org.gnome.desktop.wm.keybindings maximize "['<Super>Up']"

# Make it easy to resize undecorated windows
gsettings set org.gnome.desktop.wm.keybindings begin-resize "['<Super>BackSpace']"

# For keyboards that only have a start/stop button for music, like Logitech MX Keys Mini
gsettings set org.gnome.settings-daemon.plugins.media-keys next "['<Shift>AudioPlay']"

# Full-screen with title/navigation bar
gsettings set org.gnome.desktop.wm.keybindings toggle-fullscreen "['<Shift>F11']"

# Remove default app hotkeys, we set our own later
gsettings set org.gnome.settings-daemon.plugins.media-keys home "[]"
gsettings set org.gnome.settings-daemon.plugins.media-keys www "[]"
gsettings set org.gnome.settings-daemon.plugins.media-keys help "[]"

# Cancel input capture with Super+Shift+Escape
gsettings set org.gnome.mutter.keybindings cancel-input-capture "['<Super><Shift>Escape']"

# Open Tactile settings with Super+Control+T
gsettings set org.gnome.shell.extensions.tactile show-settings "['<Super><Control>t']"

# Use alt for pinned apps
gsettings set org.gnome.shell.keybindings switch-to-application-1 "['<Alt>1']"
gsettings set org.gnome.shell.keybindings switch-to-application-2 "['<Alt>2']"
gsettings set org.gnome.shell.keybindings switch-to-application-3 "['<Alt>3']"
gsettings set org.gnome.shell.keybindings switch-to-application-4 "['<Alt>4']"
gsettings set org.gnome.shell.keybindings switch-to-application-5 "['<Alt>5']"
gsettings set org.gnome.shell.keybindings switch-to-application-6 "['<Alt>6']"
gsettings set org.gnome.shell.keybindings switch-to-application-7 "['<Alt>7']"
gsettings set org.gnome.shell.keybindings switch-to-application-8 "['<Alt>8']"
gsettings set org.gnome.shell.keybindings switch-to-application-9 "['<Alt>9']"

# Use super for workspaces
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-1 "['<Super>1']"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-2 "['<Super>2']"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-3 "['<Super>3']"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-4 "['<Super>4']"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-5 "['<Super>5']"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-6 "['<Super>6']"

# Reserve slots for input source switching
gsettings set org.gnome.desktop.wm.keybindings switch-input-source "@as []"

# Empty the custom keybindings to start fresh
gsettings set org.gnome.settings-daemon.plugins.media-keys custom-keybindings "[]"

# Set apps launcher (wofi) to Super+Space
omadeb-keybinding-add 'Apps Launcher' 'omadeb-apps' '<Super>space'

# Set omadeb menu to Alt+Super+Space
omadeb-keybinding-add 'Omadeb Menu' 'omadeb-menu' '<Alt><Super>space'

# Set omadeb theme switcher to Super+Shift+Control+Space
omadeb-keybinding-add 'Omadeb Themes' 'omadeb-menu theme' '<Super><Shift><Control>space'

# Set omadeb next background to Super+Shift+Control
omadeb-keybinding-add 'Omadeb Background Next' 'omadeb-theme-bg-next' '<Super><Control>space'

# Set flameshot (with the sh fix for starting under Wayland) on alternate print screen key
omadeb-keybinding-add 'Flameshot' 'sh -c -- "flameshot gui"' '<Control>Print'

# Turn brightness down on Apple monitor (requires ASDControl installed)
omadeb-keybinding-add 'Apple Brightness Down (ASDControl)' "omadeb-brightness-apple-display -5000" '<Control>F1'

# Turn brightness up on Apple monitor (requires ASDControl installed)
omadeb-keybinding-add 'Apple Brightness Up (ASDControl)' "omadeb-brightness-apple-display +5000" '<Control>F2'

# Turn brightness up to max on Apple monitor (requires ASDControl installed)
omadeb-keybinding-add 'Apple Brightness Max (ASDControl)' "omadeb-brightness-apple-display +60000" '<Control><Shift>F2'

# Set night light toggle to Super+Control+N
omadeb-keybinding-add 'Night Light Toggle' 'omadeb-toggle-nightlight' '<Super><Control>n'

# Set screen lock to Super+L
omadeb-keybinding-add 'Omadeb System' 'omadeb-menu system' '<Super>Escape'

# Set applications hotkeys
omadeb-keybinding-add 'Terminal' 'xdg-terminal-exec' '<Super>Return'
omadeb-keybinding-add 'Default Terminal' 'x-terminal-emulator' '<Control><Alt>t'
omadeb-keybinding-add 'Browser' 'omadeb-launch-browser --new-window' '<Shift><Super>b'
omadeb-keybinding-add 'Browser (Alt)' 'omadeb-launch-browser --new-window' '<Shift><Super>Return'
omadeb-keybinding-add 'Incognito Browser' 'omadeb-launch-browser --private' '<Shift><Alt><Super>b'
omadeb-keybinding-add 'File Manager' 'nautilus --new-window' '<Shift><Super>f'
omadeb-keybinding-add 'Activity' 'omadeb-launch-tui btop' '<Super><Shift>t'
omadeb-keybinding-add 'Docker' 'omadeb-launch-tui lazydocker' '<Super><Shift>d'
omadeb-keybinding-add 'Spotify' 'spotify' '<Super><Shift>m'
omadeb-keybinding-add 'Editor' 'omadeb-launch-editor' '<Super><Shift>n'

# Set webapps hotkeys
omadeb-keybinding-add 'ChatGPT' 'omadeb-launch-webapp "https://chatgpt.com" "ChatGPT"' '<Super><Shift>a'
omadeb-keybinding-add 'WhatsApp' 'omadeb-launch-webapp "WhatsApp" "https://web.whatsapp.com/" "WhatsApp"' '<Super><Shift><Alt>g'
omadeb-keybinding-add 'YouTube' 'omadeb-launch-webapp "https://youtube.com/" "YouTube"' '<Super><Shift>y'
omadeb-keybinding-add 'GitHub' 'omadeb-launch-webapp "https://github.com/" "GitHub"' '<Super><Shift>h'
omadeb-keybinding-add 'X' 'omadeb-launch-webapp "https://x.com/" "X"' '<Super><Shift>x'

# Enable Compose key on Caps Lock
gsettings set org.gnome.desktop.input-sources xkb-options "['compose:caps']"