#!/bin/bash

# Variables
DOTFILES_REPO="https://github.com/your-username/dotfiles.git" # Replace with your dotfiles repository
DOTFILES_DIR="$HOME/dotfiles"
CONFIG_DIR="$HOME/.config"
NERDFONTS_REPO="https://github.com/ryanoasis/nerd-fonts.git"
NERDFONTS_DIR="$HOME/nerd-fonts"
APPS_TO_INSTALL=("git" "unzip" "curl" "clang" "xz" "mesa-libGLU" "cmake" "ninja-build" "pkg-config" "zsh" "neovim" "curl" "htop" "gnome-tweaks" "tmux" "waybar" "hyprland" "wofi" "kitty" "direnv" "ImageMagick" "ripgrep" "fd" "emacs" "libtool" "swaybg")
GROUPS_TO_INSTALL=("c-development" "development-tools")
IOSEVKA_URL="https://github.com/be5invis/Iosevka/releases/download/v32.4.0/PkgTTC-Iosevka-32.4.0.zip"
FONT_DIR="$HOME/.local/share/fonts"
TMP_DIR="/tmp/iosevka"


# Function to check if Iosevka is installed
is_iosevka_installed() {
  fc-list | grep -i "iosevka" &> /dev/null
  return $?
}

# Ensure sudo is available
if ! command -v sudo &> /dev/null; then
  echo "sudo is not installed. Please install it first."
  exit 1
fi

Update and upgrade system
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
ln -sf "$DOTFILES_DIR/.config/nvim" "$CONFIG_DIR"
ln -sf "$DOTFILES_DIR/.config/emacs" "$CONFIG_DIR"
ln -sf "$DOTFILES_DIR/.config/wofi" "$CONFIG_DIR"
ln -sf "$DOTFILES_DIR/.config/hypr" "$CONFIG_DIR"
ln -sf "$DOTFILES_DIR/.config/waybar" "$CONFIG_DIR"
ln -sf "$DOTFILES_DIR/.zshrc" "$HOME/.zshrc"
ln -sf "$DOTFILES_DIR/.tmux.conf" "$HOME/.tmux.conf"
cp "$DOTFILES_DIR/.config/wallpaper.jpg" "$HOME/Pictures/wallpaper.jpg"

# Set Zsh as the default shell
echo "Setting Zsh as the default shell..."
if command -v zsh &> /dev/null; then
  chsh -s "$(command -v zsh)"
else
  echo "Zsh is not installed. Please ensure it is installed correctly."
  exit 1
fi

if is_iosevka_installed; then
  echo "Iosevka is already installed. Skipping installation."
else
  # Create temporary directory for download
  echo "Creating temporary directory..."
  mkdir -p "$TMP_DIR"

  # Download and extract the Iosevka fonts
  echo "Downloading Iosevka fonts from $IOSEVKA_URL..."
  curl -L "$IOSEVKA_URL" -o "$TMP_DIR/iosevka.zip"

  echo "Extracting fonts..."
  unzip -o "$TMP_DIR/iosevka.zip" -d "$TMP_DIR"

  # Install fonts
  echo "Installing Iosevka fonts..."
  mkdir -p "$FONT_DIR"
  cp "$TMP_DIR"/*.ttc "$FONT_DIR"

  # Update font cache
  echo "Updating font cache..."
  fc-cache -f

  # Cleanup
  echo "Cleaning up temporary files..."
  rm -rf "$TMP_DIR"

  echo "Iosevka fonts installed successfully!"
fi

# Install Nerd Fonts (shallow clone)
if [ ! -d "$NERDFONTS_DIR" ]; then
  echo "Cloning Nerd Fonts repository (shallow)..."
  git clone --depth 1 "$NERDFONTS_REPO" "$NERDFONTS_DIR"
else
  echo "Nerd Fonts repository already exists at $NERDFONTS_DIR"
fi

echo "Installing Nerd Fonts..."
bash "$NERDFONTS_DIR/install.sh"


# Install Oh My Zsh
echo "Installing Oh My Zsh..."
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" --unattended
else
  echo "Oh My Zsh is already installed."
fi



echo "Setup complete! Log out and log back in to apply changes."
