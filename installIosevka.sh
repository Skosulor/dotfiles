#!/bin/bash

# Variables
IOSEVKA_URL="https://github.com/be5invis/Iosevka/releases/download/v32.4.0/PkgTTC-Iosevka-32.4.0.zip"
FONT_DIR="$HOME/.local/share/fonts"
TMP_DIR="/tmp/iosevka"

is_iosevka_installed() {
  fc-list | grep -i "iosevka" &> /dev/null
  return $?
}

# Ensure curl and unzip are installed
echo "Checking for required tools..."
if ! command -v curl &> /dev/null || ! command -v unzip &> /dev/null; then
  echo "Installing required tools: curl, unzip..."
  sudo dnf install -y curl unzip
fi

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

# Done
echo "Iosevka fonts installed successfully!"
