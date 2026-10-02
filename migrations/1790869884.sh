echo "Move the Omakasui APT sources to the keyring packages"

if [[ $(omadeb-version-branch) == "dev" ]]; then
  omadeb-refresh-apt dev
else
  omadeb-refresh-apt stable
fi
