#!/bin/bash
# Symlink dotfiles into $HOME
set -euo pipefail

DRY_RUN=false
[[ "${1:-}" == "-n" || "${1:-}" == "--dry-run" ]] && DRY_RUN=true

DOTFILES="$(cd "$(dirname "$0")" && pwd)"

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

# Kiro - folder links
for dir in agents prompts steering skills; do
  link "$DOTFILES/.kiro/$dir" "$HOME/.kiro/$dir"
done

# Kiro - file links
link "$DOTFILES/.kiro/settings/cli.json" "$HOME/.kiro/settings/cli.json"
