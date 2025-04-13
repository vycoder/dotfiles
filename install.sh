#!/usr/bin/env bash

set -e
exec > >(tee -i install.log)
exec 2>&1

echo "🚀 Installing apt packages..."
sudo apt update
sudo apt install -y git python3-pip zsh fonts-powerline ripgrep tree

echo "🔩 Switching default shell to zsh..."
chsh -s "$(command -v zsh)"

DOTFILES_DIR="${DOTFILES_DIR:-$HOME/dotfiles}"

echo "🚀 Installing OhMyZsh..."
CHSH=yes RUNZSH=no sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

echo "🚀 Installing powerlevl10k zsh custom theme..."
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k"

echo "🚀 Installing sdkman..."
curl -s "https://get.sdkman.io" | bash
source "$HOME/.sdkman/bin/sdkman-init.sh"
sdk install java 17.0.14-tem

echo "🚀 Installing NVM..."
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.2/install.sh | bash
nvm install 18 # set default node version

# Neovim Install
if ! command -v nvim >/dev/null || [[ "$(nvim --version | head -n1 | cut -d ' ' -f2)" < "0.10" ]]; then
 	echo "🚀 Installing Neovim 0.10+"
	sudo add-apt-repository ppa:neovim-ppa/unstable -y
	sudo apt update
	sudo apt install -y neovim
fi


echo "🚀 Installing Nerd Fonts..."
## Install nerdfonts, prerequisites for AstroNvim
sudo mkdir -p /usr/local/share/fonts/nerd-fonts

## Download and unzip UbuntuMono Nerd Font
curl -fLo /tmp/UbuntuMono.zip https://github.com/ryanoasis/nerd-fonts/releases/latest/download/UbuntuMono.zip
sudo unzip -o /tmp/UbuntuMono.zip -d /usr/local/share/fonts/nerd-fonts/
rm /tmp/UbuntuMono.zip

## Download and unzip Hasklug Nerd Font
curl -fLo /tmp/Hasklug.zip https://github.com/ryanoasis/nerd-fonts/releases/latest/download/Hasklug.zip
sudo unzip -o /tmp/Hasklug.zip -d /usr/local/share/fonts/nerd-fonts/
rm /tmp/Hasklug.zip

## Refresh font cache
fc-cache -fv


echo "🚀 Installing Kitty Terminal..."
# Kitty terminal installation
curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin

mkdir -p ~/.local/bin
ln -sf ~/.local/kitty.app/bin/kitty ~/.local/bin/kitty

cp ~/.local/kitty.app/share/applications/kitty.desktop ~/.local/share/applications/
cp ~/.local/kitty.app/share/applications/kitty-open.desktop ~/.local/share/applications/
sed -i "s|Icon=kitty|Icon=kitty-custom|g" ~/.local/share/applications/kitty.desktop
sed -i "s|Icon=kitty|Icon=kitty-custom|g" ~/.local/share/applications/kitty-open.desktop


## Copy the .desktop file locally to modify it safely
mkdir -p ~/.local/share/applications
cp ~/.local/kitty.app/share/applications/kitty.desktop ~/.local/share/applications/


echo "🚀 Installing tree-sitter cli"
npm install -g tree-sitter-cli

echo "🚀 Installing Lazygit"
LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | \grep -Po '"tag_name": *"v\K[^"]*')
curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/download/v${LAZYGIT_VERSION}/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
tar xf lazygit.tar.gz lazygit
sudo install lazygit -D -t /usr/local/bin/

## Install bottom
curl -LO https://github.com/ClementTsang/bottom/releases/download/0.10.2/bottom_0.10.2-1_amd64.deb
sudo dpkg -i bottom_0.10.2-1_amd64.deb


echo "🚀 Installing Quasar CLI"
npm install -g @quasar/cli
npm install -g @quasar/icongenie

npm install --global yarn


echo "🔩 Setting up Colemak Keyboard Layout..."
# Install Colemak Layout
python3 -m pip install --user kalamine
## Compile and install the layout
xkalamine install "$DOTFILES_DIR/.keyboard-layouts/colemak-dhk-matrix.toml"


## Set layout immediately
setxkbmap us -variant ColemakDHKMatrix

## Add to GUI selector (evdev.xml)
EVDEV_XML=/usr/share/X11/xkb/rules/evdev.xml

if ! grep -q ColemakDHKMatrix "$EVDEV_XML"; then
  echo "Adding ColemakDHKMatrix to GUI layout selector..."
  sudo sed -i '/<variantList>/{:a;N;/<\/variantList>/!ba;s|<variantList>|<variantList>\n        <variant>
          <configItem>
            <name>ColemakDHKMatrix</name>
            <description>Colemak DHK Matrix</description>
          </configItem>
        </variant>|}' "$EVDEV_XML"
fi


echo "🚀 Setting up dotfiles..."

# Symlink dotfiles
ln -sf "$DOTFILES_DIR/.zshrc" "$HOME/.zshrc"
echo "🔗 Linked .zshrc"
ln -sf "$DOTFILES_DIR/.p10k.zsh" "$HOME/.p10k.zsh"
echo "🔗 Linked .p10k.zsh"
ln -sf "$DOTFILES_DIR/.gitconfig" "$HOME/.gitconfig"
echo "🔗 Linked .gitconfig"

# Optionally create ~/.config and link config directories
echo "🔩 Setting up .config directory..."
mkdir -p ~/.config

echo "🔗 Linking nvim configuration..."
ln -sf "$DOTFILES_DIR/.config/nvim" "$HOME/.config/nvim"
nvim --headless -c 'quitall'
echo "🔗 Linking kitty configuration..."
ln -sf "$DOTFILES_DIR/.config/kitty" "$HOME/.config/kitty"

## Update the .desktop entry to point to the whiskers icon
sed -i 's|^Icon=.*|Icon='"$HOME"'/.config/kitty/kitty.app.png|' ~/.local/share/applications/kitty.desktop

echo "🔗 Linking nightfox themes"
ln -sf "$DOTFILES_DIR/.config/nightfox" "$HOME/.config/nightfox"

echo "⚙️ Cleaning up.."
rm lazygit.tar.gz lazygit
rm bottom_0.10.2-1_amd64.deb


echo "✅ sofia-x Environment Setup Complete..."
## Update desktop database
update-desktop-database ~/.local/share/applications

read -p "Press enter to reboot, or Ctrl+C to cancel..." _
sudo reboot now

