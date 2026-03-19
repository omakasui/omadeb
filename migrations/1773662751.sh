echo "Migrate from omakasui-nvim to omadeb-nvim"
if omadeb-pkg-present omakasui-nvim; then
    omadeb-pkg-drop omakasui-nvim
fi
omadeb-pkg-add omadeb-nvim