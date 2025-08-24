



# Load git-prompt.sh (path may differ)
source /opt/homebrew/etc/bash_completion.d/git-prompt.sh


# Enable useful indicators
export GIT_PS1_SHOWDIRTYSTATE=1      # * for unstaged, + for staged
export GIT_PS1_SHOWSTASHSTATE=1      # $ if something stashed
export GIT_PS1_SHOWUNTRACKEDFILES=1  # % if untracked files
export GIT_PS1_SHOWUPSTREAM="auto"   # ↑/↓ for commits to push/pull

# Modified PS1
PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@macbook\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\[\033[33m\]$(__git_ps1 " (%s)")\[\033[00m\]\$ '



export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
