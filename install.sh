#!/bin/bash
# Symlink dotfiles into $HOME
set -euo pipefail

DRY_RUN=false
[[ "${1:-}" == "-n" || "${1:-}" == "--dry-run" ]] && DRY_RUN=true

DOTFILES="$(cd "$(dirname "$0")" && pwd)"

# Update package index
if ! $DRY_RUN; then
  sudo apt-get update -qq
else
  echo "[dry-run] would run apt-get update"
fi

link() {
  local src="$1" dest="$2"
  if [ ! -e "$src" ]; then
    echo "warn: source not found, skipping: $src"
    return
  fi
  if [ -L "$dest" ]; then
    echo "skip (already linked): $dest"
    return
  fi
  if [ -e "$dest" ]; then
    local bak="${dest}.bak.$(date +%Y%m%d%H%M%S)"
    if $DRY_RUN; then
      echo "[dry-run] would backup: $dest -> $bak"
    else
      mv "$dest" "$bak"
      echo "backup: $dest -> $bak"
    fi
  fi
  if $DRY_RUN; then
    echo "[dry-run] would link: $dest -> $src"
  else
    mkdir -p "$(dirname "$dest")"
    ln -s "$src" "$dest"
    echo "linked: $dest -> $src"
  fi
}

# Zsh
if ! command -v zsh &>/dev/null; then
  echo "Installing zsh..."
  if ! $DRY_RUN; then
    sudo apt-get install -y -qq zsh
  else
    echo "[dry-run] would install zsh"
  fi
fi

if [ "$SHELL" != "$(command -v zsh)" ] && command -v zsh &>/dev/null; then
  if ! $DRY_RUN; then
    chsh -s "$(command -v zsh)"
    echo "Default shell changed to zsh"
  else
    echo "[dry-run] would change default shell to zsh"
  fi
fi

link "$DOTFILES/.zshrc" "$HOME/.zshrc"
link "$DOTFILES/.zprofile" "$HOME/.zprofile"

# Kiro - folder links
for dir in agents prompts steering skills; do
  link "$DOTFILES/.kiro/$dir" "$HOME/.kiro/$dir"
done

# Kiro - file links
link "$DOTFILES/.kiro/settings/cli.json" "$HOME/.kiro/settings/cli.json"
