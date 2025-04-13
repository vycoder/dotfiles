#!/bin/bash
set -e

REPO_URL="https://github.com/vycoder/dotfiles.git"
CLONE_DIR="$HOME/dotfiles"

# Clone only if it doesn't exist
if [ ! -d "$CLONE_DIR" ]; then
  git clone --depth=1 "$REPO_URL" "$CLONE_DIR"
fi

# Run install.sh
cd "$CLONE_DIR"
exec bash install.sh

