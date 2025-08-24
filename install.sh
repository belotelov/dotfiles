#!/usr/bin/env bash
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"
APPLY=false

print_help() {
  cat <<EOF
Usage: $(basename "$0") [options]

Install dotfiles from $DOTFILES_DIR into your home directory.

Options:
  -a, --apply   Actually perform symlinking (default is dry run).
  -h, --help    Show this help message and exit.

Behavior:
  • Recursively finds all files in the repo (excluding .git and this script).
  • For each file, would create a symlink under \$HOME with a leading dot.
    Example: bash/bashrc -> ~/.bash/bashrc
  • In dry-run mode (default), only prints what would happen.
  • In apply mode, backs up existing files (not symlinks) by renaming to <file>.backup,
    replaces old symlinks, and creates new ones.
EOF
}

backup_and_link() {
  local src=$1
  local dest=$2

  if [ "$APPLY" = false ]; then
    if [ -e "$dest" ] && [ ! -L "$dest" ]; then
      echo "📦 Would back up $dest -> $dest.backup"
    fi
    if [ -L "$dest" ]; then
      echo "❌ Would remove old symlink $dest"
    fi
    echo "🔗 Would link $src -> $dest"
  else
    if [ -e "$dest" ] && [ ! -L "$dest" ]; then
      echo "📦 Backing up $dest -> $dest.backup"
      mv "$dest" "$dest.backup"
    fi
    if [ -L "$dest" ]; then
      rm "$dest"
    fi
    mkdir -p "$(dirname "$dest")"
    echo "🔗 Linking $src -> $dest"
    ln -s "$src" "$dest"
  fi
}

# --- Main ---
for arg in "$@"; do
  case "$arg" in
    -a|--apply) APPLY=true ;;
    -h|--help) print_help; exit 0 ;;
    *) echo "Unknown option: $arg"; print_help; exit 1 ;;
  esac
done

if [ "$APPLY" = false ]; then
  echo "📝 Dry run (no changes will be made). Use --apply to perform actions."
else
  echo "🚀 Applying dotfiles installation from $DOTFILES_DIR"
fi

find "$DOTFILES_DIR" -type f \
  ! -path "$DOTFILES_DIR/.git/*" \
  ! -name "install.sh" \
| while read -r src; do
    rel="${src#$DOTFILES_DIR/}"
    dest="$HOME/.$rel"
    backup_and_link "$src" "$dest"
  done

if [ "$APPLY" = false ]; then
  echo "✅ Dry run complete. Re-run with --apply to apply changes."
else
  echo "✅ Dotfiles installation complete!"
fi
