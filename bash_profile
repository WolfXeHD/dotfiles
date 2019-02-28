HISTSIZE=5000
HISTFILESIZE=10000

export PATH
export CLICOLOR=1

export LSCOLORS=GxFxCxDxBxegedabagaced
export HISTCONTROL=ignoreboth:erasedups

export LANG="en_US.UTF-8"
export LC_COLLATE="en_US.UTF-8"
export LC_CTYPE="en_US.UTF-8"
export LC_MESSAGES="en_US.UTF-8"
export LC_MONETARY="en_US.UTF-8"
export LC_NUMERIC="en_US.UTF-8"
export LC_TIME="en_US.UTF-8"
export LC_ALL=

alias mate="/Applications/MacPorts/TextMate.app/Contents/MacOS/TextMate"
alias lognik="ssh -Y twolf@login.nikhef.nl"
alias eclipse="/Applications/eclipse/eclipse"
alias skim='/Applications/Skim.app/Contents/MacOS/Skim'
alias jaxo="java -jar /Users/timwolf/Physics/jaxodraw-2.1-0/jaxodraw-2.1-0.jar"
alias gtp="cd ~/nikhef/project/"
alias gtd="cd ~/nikhef/data/"

alias lxplus="ssh -Y tiwolf@lxplus.cern.ch"
lx() {
  ssh -Y tiwolf@lxplus$1.cern.ch
}

bind 'set completion-ignore-case on'

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
alias ta="tmux attach"
alias ll="ls -ltrh"
alias mnik="mount.sh"
alias unik="umount.sh"

alias root="root -l"

export PATH="/usr/local/opt/expat/bin:$PATH"
export PATH="/usr/local/opt/openssl/bin:$PATH"
export PATH="/usr/local/bin:$PATH"
export PATH="/usr/local/Cellar/perl/5.24.1/bin:$PATH"

export LD_LIBRARY_PATH=$ROOTSYS/lib:$PYTHONDIR/lib:$LD_LIBRARY_PATH
export PYTHONPATH=$ROOTSYS/lib:$PYTHONPATH

. /usr/local/opt/root6/libexec/thisroot.sh

export SVN_EDITOR=vim
export PYTHIA8=/Users/timwolf/pythia8205/pythia8205

export PATH=/usr/local/bin:/usr/local/sbin:$PATH
export PATH=/Users/timwolf/nikhef:$PATH
export PATH=/Users/timwolf/UsefulThings:$PATH
export PATH=/Users/timwolf/UsefulThings/gallery:$PATH

alias mult="if [ ! -d ~/nikhef/project/results/git/MultiBDT ]; then
              sshfs -o allow_root twolf@login.nikhef.nl:/project/atlas/users/twolf /Users/timwolf/nikhef/project
              sleep 1s
            fi
            cd ~/nikhef/project/results/git/MultiBDT"

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

