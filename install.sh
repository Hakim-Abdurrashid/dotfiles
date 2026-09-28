#!/bin/bash

#exit immediately if a command exits with a non-zero status
set -e

#prompt the user for Git identity credentials
echo -n "Enter your Git Full Name: "
read -r git_name

echo -n "Enter your Git Email Address: "
read -r git_email

#apply captured stdin directly to ~/.gitconfig
git config --global user.name "$git_name"
git config --global user.email "$git_email"

echo "Git identity configured for $git_name <$git_email>"

#prompt the user for preferred GitHub clone protocol
echo -n "Choose your preferred GitHub clone protocol (\"ssh\" or \"https\"): "
read -r protocol

#configure global git alias based on user choice
if [ "$protocol" = "ssh" ] || [ "$protocol" = "SSH" ]; then
    git config --global alias.cl "!f() { git clone git@github.com:\$1; }; f"
    echo "Configured 'git cl' to use SSH (git@github.com:...)"
elif [ "$protocol" = "https" ] || [ "$protocol" = "HTTPS" ]; then
    git config --global alias.cl "!f() { git clone https://github.com/\$1; }; f"
    echo "Configured 'git cl' to use HTTPS (https://github.com/...)"
else
    echo "Unrecognized input. Defaulting to SSH."
    git config --global alias.cl "!f() { git clone git@github.com:\$1; }; f"
fi

#automatically git fetch all repositories
DOTFILES_DIR="$HOME/dotfiles"

chmod +x "$DOTFILES_DIR/gitfetch_all_repositories.sh"

#create the systemd user directory if it doesn't exist
mkdir -p "$HOME/.config/systemd/user"

#symlink the service file
ln -sf "$DOTFILES_DIR/gitfetch_all_repositories.service" "$HOME/.config/systemd/user/gitfetch_all_repositories.service"

#reload systemd and enable the service to run on network startup
systemctl --user daemon-reload
systemctl --user enable gitfetch_all_repositories.service

echo "Configured!"