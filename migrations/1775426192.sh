if [ ! -f "$HOME/.config/omadeb/current/theme/walker.css" ]; then
    echo "Reapply current theme to update it with the new walker.css file"
    omadeb-theme-set "$(omadeb-theme-current)"
fi