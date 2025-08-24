#!/usr/bin/env bash
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"
DOTFILES_PRIVATE_DIR="${DOTFILES_DIR}-private"
APPLY=false

print_help() {
  cat <<EOF
Usage: $(basename "$0") [options]

Install dotfiles from $DOTFILES_DIR and $DOTFILES_PRIVATE_DIR into your home directory.

Options:
  -a, --apply   Actually perform symlinking (default is dry run).
  -h, --help    Show this help message and exit.

Behavior:
  • Recursively finds all files in both repos (excluding .git and this script).
  • For each file, would create a symlink under \$HOME with a leading dot.
    Example: bash/bashrc -> ~/.bash/bashrc
  • In dry-run mode (default), only prints what would happen.
  • In apply mode, backs up existing files (not symlinks) by renaming to <file>.backup,
    replaces old symlinks, and creates new ones.
  • Private repo files take precedence over public repo files.
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

install_from_repo() {
  local repo_dir=$1
  local repo_name=$2
  
  if [ ! -d "$repo_dir" ]; then
    echo "⚠️  Warning: $repo_name directory not found at $repo_dir"
    return
  fi
  
  echo "📁 Processing $repo_name from $repo_dir"
  
  find "$repo_dir" -type f \
    ! -path "$repo_dir/.git/*" \
    ! -name "install.sh" \
    ! -name "README.md" \
    ! -name ".gitignore" \
  | while read -r src; do
      rel="${src#$repo_dir/}"
      dest="$HOME/.$rel"
      backup_and_link "$src" "$dest"
    done
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
  echo "🚀 Applying dotfiles installation from $DOTFILES_DIR and $DOTFILES_PRIVATE_DIR"
fi

# Install public dotfiles first
install_from_repo "$DOTFILES_DIR" "public dotfiles"

# Install private dotfiles second (will override public ones)
install_from_repo "$DOTFILES_PRIVATE_DIR" "private dotfiles"

if [ "$APPLY" = false ]; then
  echo "✅ Dry run complete. Re-run with --apply to apply changes."
else
  echo "✅ Dotfiles installation complete!"
fi
