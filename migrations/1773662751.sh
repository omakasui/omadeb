echo "Migrate to Walker from Wofi"
omadeb-pkg-add omakasui-walker
omadeb-pkg-drop wofi

# Apply Walker and Elephant changes immediately
mkdir -p ~/.config/walker/
cp -f $OMADEB_PATH/config/walker/config.toml ~/.config/walker/config.toml

mkdir -p ~/.config/elephant/
cp -f $OMADEB_PATH/config/elephant/calc.toml ~/.config/elephant/calc.toml
cp -f $OMADEB_PATH/config/elephant/desktopapplications.toml ~/.config/elephant/desktopapplications.toml
cp -f $OMADEB_PATH/config/elephant/symbols.toml ~/.config/elephant/symbols.toml

bash $OMADEB_PATH/install/config/walker-elephant.sh

# Set omadeb next background to Super+Shift+Control
omadeb-keybinding-remove 'Omadeb Background Next'
omadeb-keybinding-add 'Omadeb Background Next' 'omadeb-menu background' '<Super><Control>space'

bash $OMADEB_PATH/install/first-run/elephant.sh

# Require a logout to apply the new keybinding and menu changes
omadeb-state set logout-required
