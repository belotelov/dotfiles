



# Load git-prompt.sh (path may differ)
if [ -f /opt/homebrew/etc/bash_completion.d/git-prompt.sh ]; then
    # macOS (Homebrew)
    source /opt/homebrew/etc/bash_completion.d/git-prompt.sh
elif [ -f /usr/share/git/completion/git-prompt.sh ]; then
    # Common Linux location (Debian/Ubuntu)
    source /usr/share/git/completion/git-prompt.sh
elif [ -f /etc/bash_completion.d/git-prompt ]; then
    # Some other Linux distros
    source /etc/bash_completion.d/git-prompt
fi


# Enable useful indicators
export GIT_PS1_SHOWDIRTYSTATE=1      # * for unstaged, + for staged
export GIT_PS1_SHOWSTASHSTATE=1      # $ if something stashed
export GIT_PS1_SHOWUNTRACKEDFILES=1  # % if untracked files
export GIT_PS1_SHOWUPSTREAM="auto"   # ↑/↓ for commits to push/pull

# Modified PS1
if type __git_ps1 &>/dev/null; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@macbook\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\[\033[33m\]$(__git_ps1 " (%s)")\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@macbook\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
fi



export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
