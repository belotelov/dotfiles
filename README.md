# Dotfiles

Personal configuration files and shell customizations.

This repository contains my **dotfiles** — configuration files for shell, editors, terminal multiplexers, and other tools I use daily for development (ML, cloud, and general programming). It’s structured to be portable across machines, and comes with an installer script that symlinks everything into place.

## Contents
- **bash/** – `.bashrc`, aliases, and environment tweaks  
- **git/** – `.gitconfig`, global `.gitignore`  
- **screen/** – `.screenrc`  
- **tmux/** – `.tmux.conf`  
- **vim/** – `.vimrc`  
- **misc/** – small helper scripts, functions  

## Features
- One-command install via `install.sh` (defaults to dry-run; run with `--apply` to actually symlink)  
- Automatic backup of existing configs before linking  
- Organized by tool for easier navigation and extension  
- Safe for public use (no secrets committed; sensitive files are kept in a private repo)  

## Usage
Clone and preview what will be installed:
```bash
git clone https://github.com/ibelotelov/dotfiles.git ~/dotfiles
cd ~/dotfiles
./install.sh         # dry run (default)
./install.sh --apply # apply symlinks
