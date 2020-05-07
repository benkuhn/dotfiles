local NIX_SOURCE="$HOME/.nix-profile/etc/profile.d/nix.sh"

if [[ -f "$NIX_SOURCE" ]]; then
    source $NIX_SOURCE
    myconfigs[nix]=installed
else
    myconfigs[nix]=not-installed
fi
