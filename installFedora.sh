#!/bin/bash

# Variables
DOTFILES_REPO="https://github.com/your-username/dotfiles.git" # Replace with your dotfiles repository
DOTFILES_DIR="$HOME/dotfiles"
CONFIG_DIR="$HOME/.config"
APPS_TO_INSTALL=("git" "unzip" "git" "clang" "xz" "mesa-libGLU" "cmake" "ninja-build" "pkg-config" "zsh" "neovim" "curl" "htop" "gnome-tweaks" "tmux" "waybar" "hyprland" "wofi" "kitty" "direnv" "imagemagick" "ripgrep" "fd" "emacs" "ghostty") 
GRPOUPS_TO_INSTALL=("c-development" "development-tools")

# Ensure sudo is available
if ! command -v sudo &> /dev/null; then
  echo "sudo is not installed. Please install it first."
  exit 1
fi

# Update and upgrade system
echo "Updating and upgrading system..."
sudo dnf update -y && sudo dnf upgrade -y

# Install essential applications
echo "Installing essential applications..."
sudo dnf install -y "${APPS_TO_INSTALL[@]}"

# Clone dotfiles repository
if [ ! -d "$DOTFILES_DIR" ]; then
  echo "Cloning dotfiles repository..."
  git clone "$DOTFILES_REPO" "$DOTFILES_DIR"
else
  echo "Dotfiles repository already exists at $DOTFILES_DIR"
fi

# Create symbolic links for dotfiles
echo "Creating symbolic links for dotfiles..."
mkdir -p "$CONFIG_DIR"

# Symlink individual files and directories
ln -sf "$DOTFILES_DIR/.config/nvim" "$CONFIG_DIR/nvim"
ln -sf "$DOTFILES_DIR/.config/emacs/init.el" "$CONFIG_DIR/emacs/init.el"
ln -sf "$DOTFILES_DIR/.config/wofi" "$CONFIG_DIR/wofi"
ln -sf "$DOTFILES_DIR/.config/hypr" "$CONFIG_DIR/hypr"
ln -sf "$DOTFILES_DIR/.config/waybar" "$CONFIG_DIR/waybar"
ln -sf "$DOTFILES_DIR/.zshrc" "$HOME/.zshrc"
ln -sf "$DOTFILES_DIR/.tmux.conf" "$HOME/.tmux.conf"
cp "$DOTFILES_DIR/.config/wallpaper.jpg" "$HOME/.tmux.conf"

# Set Zsh as the default shell
echo "Setting Zsh as the default shell..."
if command -v zsh &> /dev/null; then
  chsh -s "$(command -v zsh)"
else
  echo "Zsh is not installed. Please ensure it is installed correctly."
  exit 1
fi

# Install Oh My Zsh
echo "Installing Oh My Zsh..."
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" --unattended
else
  echo "Oh My Zsh is already installed."
fi

# Final message
echo "Setup complete! Log out and log back in to apply changes."
