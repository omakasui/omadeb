echo "Add Tmux as an option with themed styling"

omadeb-pkg-add tmux

if [[ ! -f ~/.config/tmux/tmux.conf ]]; then
  mkdir -p ~/.config/tmux
  cp $OMADEB_PATH/config/tmux/tmux.conf ~/.config/tmux/tmux.conf
  omadeb-restart-tmux
fi

echo "Add Tmux binding (Super+Alt+Return)"
omadeb-keybinding-add 'Terminal (Tmux)' 'xdg-terminal-exec bash -c "tmux attach || tmux new -s Work"' '<Super><Alt>Return'