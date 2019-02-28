export ZPLUG_HOME=/usr/local/opt/zplug
source $ZPLUG_HOME/init.zsh

HISTSIZE=5000
HISTFILESIZE=10000

export LANG="en_US.UTF-8"
export LC_COLLATE="en_US.UTF-8"
export LC_CTYPE="en_US.UTF-8"
export LC_MESSAGES="en_US.UTF-8"
export LC_MONETARY="en_US.UTF-8"
export LC_NUMERIC="en_US.UTF-8"
export LC_TIME="en_US.UTF-8"
export LC_ALL=

alias skim='/Applications/Skim.app/Contents/MacOS/Skim'

alias sb='source ~/.bash_profile'

export CLICOLOR=1
export LSCOLORS=exfxcxdxbxegedabagacad
alias ta="tmux attach"
alias ll="ls -ltrh"
alias mnik="mount.sh"
alias unik="umount.sh"

alias latexdiff="PATH=/usr/local/Cellar/perl@5.18/5.18.2/bin:$PATH && latexdiff"
alias root="root -l"

export PATH="/usr/local/Cellar/perl/5.28.0/bin:$PATH"

export LD_LIBRARY_PATH=$ROOTSYS/lib:$PYTHONDIR/lib:$LD_LIBRARY_PATH
export PYTHONPATH=$ROOTSYS/lib:$PYTHONPATH

source /usr/local/opt/root/bin/thisroot.sh
pushd /usr/local >/dev/null; . bin/thisroot.sh; popd >/dev/null

alias vim='mvim -v'

export PATH=/usr/local/bin:/usr/local/sbin:$PATH
export PATH=/Users/timwolf/nikhef:$PATH
export PATH=/Users/timwolf/UsefulThings:$PATH
export PATH=/Users/timwolf/UsefulThings/gallery:$PATH
export PATH=/Users/timwolf/.go/bin:$PATH

has_plugin() {
    (( $+functions[zplug] )) || return 1
    zplug check "${1:?too few arguments}"
    return $status
}

zplug "zplug/zplug"
zplug "zsh-users/zsh-syntax-highlighting", defer:2
zplug "zsh-users/zsh-completions"
zplug "zsh-users/zsh-history-substring-search"
zplug "zsh-users/zsh-autosuggestions", at:"develop", defer:2
AUTOSUGGESTION_HIGHLIGHT_COLOR="fg=white"
zplug "rupa/z", use:z.sh
zplug "Tarrasch/zsh-bd"
zplug "junegunn/fzf"
zplug "mafredri/zsh-async", from:github
zplug "sindresorhus/pure", use:pure.zsh, from:github, as:theme

# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

# Source plugins and add commands to $PATH
zplug load

export EDITOR='nvim'
export VISUAL='nvim'
source ~/.bin/tmuxinator.zsh

# taskwarrior aliases
alias tl='task list'
alias ta='task add $1'
alias tm='task $1 modify '
alias te='task $1 edit'

taskprojectfunction() {
  task $1 modify project:$2
}
alias tproj=taskprojectfunction

unsetopt share_history
bindkey -v
export KEYTIMEOUT=20
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
