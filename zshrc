#
# Executes commands at the start of an interactive session.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

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

alias lognik="ssh -Y twolf@login.nikhef.nl"
alias skim='/Applications/Skim.app/Contents/MacOS/Skim'
alias jaxo="java -jar /Users/timwolf/Physics/jaxodraw-2.1-0/jaxodraw-2.1-0.jar"
alias gtp="cd ~/nikhef/project/"
alias gtd="cd ~/nikhef/data/"

alias lxplus="ssh -Y tiwolf@lxplus.cern.ch"

alias stbc-i1="ssh -Y twolf@stbc-i1"
alias stbc-i2="ssh -Y twolf@stbc-i2"
alias stbc-i3="ssh -Y twolf@stbc-i3"
alias stbc-i4="ssh -Y twolf@stbc-i4"

alias ki='kinit tiwolf@CERN.CH'
alias sb='source ~/.bash_profile'

alias log-i1="ssh -t -Y twolf@login.nikhef.nl 'ssh -Y stbc-i1'"
alias log-i2="ssh -t -Y twolf@login.nikhef.nl 'ssh -Y stbc-i2'"
alias log-i3="ssh -t -Y twolf@login.nikhef.nl 'ssh -Y stbc-i3'"
alias log-i4="ssh -t -Y twolf@login.nikhef.nl 'ssh -Y stbc-i4'"
alias log-i5="ssh -t -Y twolf@login.nikhef.nl 'ssh -Y stbc-i5'"
alias log-i6="ssh -t -Y twolf@login.nikhef.nl 'ssh -Y stbc-i6'"
alias ta="tmux attach"
alias ll="ls -ltrh"
alias mnik="mount.sh"
alias unik="umount.sh"
alias latexdiff="PATH=/usr/local/Cellar/perl@5.18/5.18.2/bin:$PATH && latexdiff"
alias root="root -l"

# export PATH="/usr/local/opt/expat/bin:$PATH"
# export PATH="/usr/local/opt/openssl/bin:$PATH"
# export PATH="/usr/local/bin:$PATH"

export PATH="/usr/local/Cellar/perl/5.28.0/bin:$PATH"

export LD_LIBRARY_PATH=$ROOTSYS/lib:$PYTHONDIR/lib:$LD_LIBRARY_PATH
export PYTHONPATH=$ROOTSYS/lib:$PYTHONPATH

# source /usr/local/opt/root/bin/thisroot.sh
# pushd /usr/local >/dev/null; . bin/thisroot.sh; popd >/dev/null

alias vim='mvim -v'

export PATH=/usr/local/bin:/usr/local/sbin:$PATH
export PATH=/Users/timwolf/nikhef:$PATH
export PATH=/Users/timwolf/UsefulThings:$PATH
export PATH=/Users/timwolf/UsefulThings/gallery:$PATH
export PATH=/Users/timwolf/.go/bin:$PATH

[ -f ~/.fzf.bash ] && source ~/.fzf.zsh

if [[ -f ~/.zplug/init.zsh ]]; then
    export ZPLUG_LOADFILE=~/dotfiles/zsh/plugins.zsh
    source ~/.zplug/init.zsh

    if ! zplug check --verbose; then
        printf "Install? [y/N]: "
        if read -q; then
            echo; zplug install
        fi
        echo
    fi
    zplug load
fi

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*' verbose yes
zstyle ':completion:*' completer _expand _complete _match _prefix _approximate _list _history
zstyle ':completion:*:*files' ignored-patterns '*?.o' '*?~' '*\#'
zstyle ':completion:*' use-cache true
zstyle ':completion:*:*:-subscript-:*' tag-order indexes parameters

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
