---
name: omadeb
description: >
  REQUIRED for ANY changes to Ubuntu desktop, GNOME settings, or system config.
  Use when editing ~/.config/alacritty/, ~/.config/kitty/, ~/.config/wofi/,
  ~/.config/omadeb/, or working with GNOME settings. Triggers: GNOME extensions,
  keybindings, themes, wallpaper, terminal config, night light, dock settings,
  workspace configuration, display config, or any omadeb-* commands.
---

# Omadeb Skill

Manage [Omadeb](https://omadeb.omakasui.org/) Linux systems - an opinionated Ubuntu 24.04+ development environment.

## When This Skill MUST Be Used

**ALWAYS invoke this skill when the user's request involves ANY of these:**

- Editing ANY file in `~/.config/omadeb/`
- Editing terminal configs (alacritty, kitty)
- Working with GNOME settings (gsettings)
- GNOME extensions, dock, keybindings, appearance
- Themes, wallpapers, fonts, appearance changes
- Any `omadeb-*` command
- Night light, workspace settings, display configuration
- Application installation or removal

**If you're about to edit a config file in ~/.config/ on this Ubuntu system, STOP and use this skill first.**

## Critical Safety Rules

**NEVER modify anything in `~/.local/share/omadeb/`** - but READING is safe and encouraged.

This directory contains Omadeb's source files managed by git. Any changes will be:

- Lost on next `omadeb-update`
- Cause conflicts with upstream
- Break the system's update mechanism

```
~/.local/share/omadeb/        # READ-ONLY - NEVER EDIT (reading is OK)
├── bin/                      # Source scripts (in PATH)
├── config/                   # Default config templates
├── themes/                   # Stock themes
├── default/                  # System defaults
├── migrations/               # Update migrations
├── install/                  # Installation scripts
└── applications/             # Application install scripts
```

**Reading `~/.local/share/omadeb/` is SAFE and useful** - do it freely to:

- Understand how omadeb commands work: `cat $(which omadeb-theme-set)`
- See default configs before customizing: `cat ~/.local/share/omadeb/config/alacritty/alacritty.toml`
- Check stock theme files to copy for customization
- Browse available applications: `ls ~/.local/share/omadeb/applications/install/`

**Always use these safe locations instead:**

- `~/.config/` - User configuration (safe to edit)
- `~/.config/omadeb/themes/<custom-name>/` - Custom themes (must be real directories)
- `~/.config/omadeb/hooks/` - Custom automation hooks

## System Architecture

Omadeb is built on:

| Component           | Purpose              | Config Location            |
| ------------------- | -------------------- | -------------------------- |
| **Ubuntu 24.04+**   | Base OS              | `/etc/`, `~/.config/`      |
| **GNOME**           | Desktop environment  | GNOME settings (gsettings) |
| **Alacritty/Kitty** | Terminals            | `~/.config/<terminal>/`    |
| **Wofi**            | Application launcher | `~/.config/wofi/`          |
| **Neovim/LazyVim**  | Text editor          | `~/.config/nvim/`          |
| **Zellij**          | Terminal multiplexer | `~/.config/zellij/`        |
| **Starship**        | Shell prompt         | `~/.config/starship.toml`  |

## Command Discovery

Omadeb provides ~90 commands following `omadeb-<category>-<action>` pattern.

```bash
# List all omadeb commands
compgen -c | grep -E '^omadeb-' | sort -u

# Find commands by category
compgen -c | grep -E '^omadeb-theme'
compgen -c | grep -E '^omadeb-restart'

# Read a command's source to understand it
cat $(which omadeb-theme-set)
```

### Command Categories

| Prefix                | Purpose                                   | Example                     |
| --------------------- | ----------------------------------------- | --------------------------- |
| `omadeb-refresh-*`    | Reset config to defaults (backs up first) | `omadeb-refresh-gnome`      |
| `omadeb-restart-*`    | Restart a service/app                     | `omadeb-restart-terminal`   |
| `omadeb-toggle-*`     | Toggle feature on/off                     | `omadeb-toggle-nightlight`  |
| `omadeb-theme-*`      | Theme management                          | `omadeb-theme-set <name>`   |
| `omadeb-install-*`    | Install optional software                 | `omadeb-install-docker-dbs` |
| `omadeb-launch-*`     | Launch apps                               | `omadeb-launch-browser`     |
| `omadeb-cmd-*`        | System commands                           | `omadeb-cmd-shutdown`       |
| `omadeb-app-*`        | Application management                    | `omadeb-app-install <name>` |
| `omadeb-font-*`       | Font management                           | `omadeb-font-set <name>`    |
| `omadeb-keybinding-*` | Keybinding management                     | `omadeb-keybinding-add`     |
| `omadeb-update`       | System update                             | `omadeb-update`             |

## Configuration Locations

### GNOME Desktop

GNOME settings are managed via `gsettings` commands, not config files:

```bash
# View current GNOME settings
gsettings list-schemas | grep gnome
gsettings list-keys org.gnome.desktop.wm.keybindings

# Set GNOME settings
gsettings set org.gnome.desktop.wm.keybindings close "['<Super>w']"
```

**Key GNOME components:**

- Desktop settings: `org.gnome.desktop.*`
- Window manager: `org.gnome.desktop.wm.*`
- Extensions: `org.gnome.shell.extensions.*`
- Keybindings: `org.gnome.desktop.wm.keybindings`, `org.gnome.settings-daemon.plugins.media-keys`

**Omadeb includes these GNOME extensions:**

- Tactile (window tiling)
- Just Perfection (UI tweaks)
- Blur My Shell (visual effects)
- Space Bar (workspace management)
- TopHat (system monitoring)
- AlphabeticalAppGrid (app organization)

### Terminals

```
~/.config/alacritty/alacritty.toml
~/.config/kitty/kitty.conf
```

**Commands:** `omadeb-restart-terminal`, `omadeb-install-terminal alacritty|kitty`

### Wofi (Application Launcher)

```
~/.config/wofi/
├── config           # Main configuration
├── style.css        # Styling
└── search.css       # Search-specific styles
```

**Commands:** `omadeb-apps` (launches wofi), `omadeb-refresh-wofi`

### Other Configs

| App       | Location                           |
| --------- | ---------------------------------- |
| btop      | `~/.config/btop/btop.conf`         |
| fastfetch | `~/.config/fastfetch/config.jsonc` |
| lazygit   | `~/.config/lazygit/config.yml`     |
| neovim    | `~/.config/nvim/`                  |
| starship  | `~/.config/starship.toml`          |
| git       | `~/.config/git/config`             |
| zellij    | `~/.config/zellij/`                |

## Safe Customization Patterns

### Pattern 1: Edit User Config Directly

For simple changes, edit files in `~/.config/`:

```bash
# 1. Read current config
cat ~/.config/alacritty/alacritty.toml

# 2. Backup before changes (optional - refresh commands do this automatically)
cp ~/.config/alacritty/alacritty.toml ~/.config/alacritty/alacritty.toml.bak.$(date +%s)

# 3. Make changes with Edit tool

# 4. Apply changes
# - Terminal: MUST restart with omadeb-restart-terminal
# - Wofi: Reloads automatically on next launch
# - GNOME settings: Apply immediately (no restart needed)
```

### Pattern 2: Make a New Theme

1. Create a directory under `~/.config/omadeb/themes/`.
2. See how an existing theme is done via `~/.local/share/omadeb/themes/tokyo-night/`.
3. Download a matching background from the internet and put it in `~/.config/omadeb/themes/[name-of-new-theme]/`
4. Create theme metadata files (gnome.theme, icons.theme, etc.) in your theme directory
5. When done with the theme, run `omadeb-theme-set "Name of new theme"`

**Stock themes available:** catppuccin, catppuccin-latte, ethereal, everforest, flexoki-light, gruvbox, hackerman, kanagawa, matte-black, nord, osaka-jade, ristretto, rose-pine, tokyo-night

### Pattern 3: Use Hooks for Automation

Create scripts in `~/.config/omadeb/hooks/` to run automatically on events:

```bash
# Available hooks:
~/.config/omadeb/hooks/
├── theme-set        # Runs after theme change (receives theme name as $1)
├── font-set         # Runs after font change
└── post-update      # Runs after omadeb-update
```

Example hook (`~/.config/omadeb/hooks/theme-set`):

```bash
#!/bin/bash
THEME_NAME=$1
echo "Theme changed to: $THEME_NAME"
# Add custom actions here
```

Make hooks executable: `chmod +x ~/.config/omadeb/hooks/theme-set`

### Pattern 4: Reset to Defaults -- ALWAYS SEEK USER CONFIRMATION BEFORE RUNNING

When customizations go wrong:

```bash
# Reset specific config (creates backup automatically)
omadeb-refresh-gnome
omadeb-refresh-alacritty
omadeb-refresh-wofi

# The refresh command:
# 1. Backs up current config with timestamp
# 2. Copies default from ~/.local/share/omadeb/config/
# 3. Restarts the component if needed
```

## Common Tasks

### Themes

```bash
omadeb-theme-list              # Show available themes
omadeb-theme-current           # Show current theme
omadeb-theme-set <name>        # Apply theme (use "Tokyo Night" not "tokyo-night")
omadeb-theme-bg-next           # Cycle wallpaper
omadeb-theme-install <url>     # Install from git repo
```

Theme files affect:

- GNOME appearance (GTK theme, icons, cursor)
- Terminal colors (alacritty, kitty)
- Editor themes (VS Code, Neovim, Obsidian)
- Background wallpaper

### Keybindings

Use `omadeb-keybinding-add` and `omadeb-keybinding-remove` commands:

```bash
# Add a custom keybinding
omadeb-keybinding-add "Open Terminal" "xdg-terminal-exec" "<Primary><Alt>t"

# Remove a keybinding
omadeb-keybinding-remove "Open Terminal"

# View current custom keybindings
gsettings get org.gnome.settings-daemon.plugins.media-keys custom-keybindings
```

**Default Omadeb keybindings:**

- `Super+W` - Close window
- `Super+Up` - Maximize window
- `Super+BackSpace` - Begin window resize
- `Alt+1-9` - Switch to pinned app 1-9
- `Super+1-6` - Switch to workspace 1-6
- `Ctrl+Alt+T` - New terminal window

### Fonts

```bash
omadeb-font-list               # Available fonts
omadeb-font-current            # Current font
omadeb-font-set <name>         # Change font
omadeb-font-size-current       # Current font size
omadeb-font-size-set <size>    # Change font size
```

Default font: **CaskaydiaMono Nerd Font**

### Applications

```bash
# Install applications
omadeb-app-install <name>      # Install a single app
omadeb-install-terminal <name> # Install and set default terminal

# Available applications (in ~/.local/share/omadeb/applications/install/):
# - Browsers: brave, chromium, firefox, zen
# - Dev tools: docker, neovim, visual-studio-code, cursor, zed, github-cli
# - Terminals: alacritty, kitty
# - Utilities: 1password, obsidian, signal, discord, spotify, obs-studio
# And many more...

# Application folder management (for GNOME app grid)
omadeb-app-folder-add <app.desktop> <folder-name>
omadeb-app-folder-remove <app.desktop> <folder-name>
```

### Night Light

```bash
omadeb-toggle-nightlight       # Toggle night light on/off

# Manual configuration via gsettings:
gsettings set org.gnome.settings-daemon.plugins.color night-light-enabled true
gsettings set org.gnome.settings-daemon.plugins.color night-light-schedule-automatic true
gsettings set org.gnome.settings-daemon.plugins.color night-light-temperature 4000
```

### System

```bash
omadeb-update                  # Full system update (Ubuntu + Omadeb)
omadeb-state                   # Show Omadeb state/version
omadeb-cmd-shutdown            # Shutdown
omadeb-cmd-reboot              # Reboot
omadeb-cmd-logout              # Logout
omadeb-cmd-lock-screen         # Lock screen
```

## Troubleshooting

```bash
# Reset specific config to defaults
omadeb-refresh-<app>

# Refresh specific config file
# config-file path is relative to ~/.config/
# e.g., omadeb-refresh-config alacritty/alacritty.toml
omadeb-refresh-config <config-file>

# Refresh all GNOME settings
omadeb-refresh-gnome

# Check for updates
omadeb-update-available
```

## Decision Framework

When user requests system changes:

1. **Is it a stock omadeb command?** Use it directly
2. **Is it a GNOME setting?** Use `gsettings` or relevant omadeb command
3. **Is it a config edit?** Edit in `~/.config/`, never `~/.local/share/omadeb/`
4. **Is it a theme customization?** Create a NEW custom theme directory
5. **Is it automation?** Use hooks in `~/.config/omadeb/hooks/`
6. **Is it a package install?** Check if available via `omadeb-app-install`, otherwise use `apt`
7. **Unsure if command exists?** Search with `compgen -c | grep omadeb`

## Development (AI Agents)

When contributing to Omadeb itself (e.g., fixing bugs, adding features), migrations are used to apply changes to existing installations.

### Creating Migrations

```bash
omadeb-dev-add-migration
```

This creates a new migration file in `~/.local/share/omadeb/migrations/`. The migration filename is based on the git commit timestamp.

**Migration files** are shell scripts in `~/.local/share/omadeb/migrations/` that run once per system during `omadeb-update`. Use them for:

- Updating user configs with new defaults
- Installing new dependencies
- Running one-time setup tasks
- Applying GNOME settings changes

## Example Requests

- "Change my theme to catppuccin" -> `omadeb-theme-set catppuccin`
- "Add a keybinding for Ctrl+Alt+E to open file manager" -> `omadeb-keybinding-add "File Manager" "nautilus" "<Primary><Alt>e"`
- "Install Visual Studio Code" -> `omadeb-app-install visual-studio-code`
- "Make the terminal font bigger" -> `omadeb-font-size-set 12`
- "Set up night light to turn on automatically" -> `gsettings set org.gnome.settings-daemon.plugins.color night-light-enabled true; gsettings set org.gnome.settings-daemon.plugins.color night-light-schedule-automatic true`
- "Customize the tokyo-night theme colors" -> Create `~/.config/omadeb/themes/tokyo-night-custom/` by copying from stock, then edit
- "Run a script every time I change themes" -> Create `~/.config/omadeb/hooks/theme-set`
- "Reset GNOME settings to defaults" -> `omadeb-refresh-gnome` (after user confirmation)
- "Switch to Kitty terminal" -> `omadeb-install-terminal kitty`
- "Add Spotify to my dock" -> Edit GNOME dock favorites via `~/.local/share/omadeb/install/config/gnome/dock.sh` as reference
