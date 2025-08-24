# Dotfiles

Personal configuration files and shell customizations.

This repository contains my **dotfiles** — configuration files for shell, editors, terminal multiplexers, and other tools I use daily for development (ML, cloud, and general programming). It's structured to be portable across machines, and comes with an installer script that symlinks everything into place.

**Note**: This is the public part of my dotfiles. For complete setup, you'll also need the private repository.

## Contents
- **bashrc** – `.bashrc` configuration  
- **gitconfig** – `.gitconfig` global configuration  
- **gitignore** – Global `.gitignore` file  
- **screenrc** – `.screenrc` configuration  
- **ssh/** – SSH configuration with public and private parts  
- **misc/** – small helper scripts, functions (when added)

## Features
- One-command install via `install.sh` (defaults to dry-run; run with `--apply` to actually symlink)  
- Automatic backup of existing configs before linking  
- Organized by tool for easier navigation and extension  
- Safe for public use (no secrets committed; sensitive files are kept in a private repo)  
- **Integrated private repo support** – automatically installs from both public and private repositories

## Usage

### Complete Setup (Recommended)
Clone both repositories side by side and install everything at once:

```bash
# Clone both repos
git clone https://github.com/ibelotelov/dotfiles.git ~/dotfiles
git clone <private-repo-url> ~/dotfiles-private

# Install everything (public + private)
cd ~/dotfiles
./install.sh         # dry run (default)
./install.sh --apply # apply symlinks
```

### Public Only Setup
If you only want the public configuration:

```bash
git clone https://github.com/ibelotelov/dotfiles.git ~/dotfiles
cd ~/dotfiles
./install.sh         # dry run (default)
./install.sh --apply # apply symlinks
```

## SSH Configuration
The SSH setup uses a modular approach:
- **Public configs**: Stored in this repo under `ssh/config.d/public/`
- **Private configs**: Stored in the private repo under `ssh/config.d/private/`
- **Main config**: Includes both public and private configurations

## Security
- No secrets or private keys are committed to this repository
- Private configurations are kept in a separate private repository
- The `.gitignore` file ensures sensitive files are never accidentally committed
