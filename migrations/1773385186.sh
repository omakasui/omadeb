# Check if we're on the dev branch and refresh APT references if so
if [[ "$(omadeb-version-branch)" == "dev" ]]; then
    echo "Updating APT repository references for dev branch..."
    omadeb-refresh-apt "dev"
fi