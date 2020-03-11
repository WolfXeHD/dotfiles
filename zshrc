export ZPLUG_HOME=/usr/local/opt/zplug
source $ZPLUG_HOME/init.zsh

HISTSIZE=5000
HISTFILESIZE=10000
SAVEHIST=5000
HISTFILE=~/.bash_history
setopt EXTENDED_HISTORY
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_FIND_NO_DUPS
setopt HIST_SAVE_NO_DUPS
setopt HIST_BEEP

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
alias ll="ls -ltrha"
alias mnik="mount.sh"
alias unik="umount.sh"

alias root="root -l"
alias wget_arxiv="wget --user-agent=\"Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/51.0.2704.103 Safari/537.36\""

fpath=(/usr/local/share/zsh-completions $fpath)


alias log-mid2='ssh twolf@midway2-login1.rcc.uchicago.edu'
alias log-dali1='ssh twolf@dali-login1.rcc.uchicago.edu'
alias log-dali2='ssh twolf@dali-login2.rcc.uchicago.edu'
# eval "$(docker-machine env default)"

export LD_LIBRARY_PATH=$ROOTSYS/lib:$PYTHONDIR/lib:$LD_LIBRARY_PATH
export PYTHONPATH=$ROOTSYS/lib:$PYTHONPATH
export PATH="/usr/local/anaconda3/bin:$PATH"
export PATH=/usr/local/bin:/usr/local/sbin:$PATH
export PATH=/Users/twolf/Physics/UsefulTools/gallery:$PATH

source /usr/local/opt/root/bin/thisroot.sh
pushd /usr/local >/dev/null; . bin/thisroot.sh; popd >/dev/null

alias vim='mvim -v'


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
alias tlw='task -private list'

ulimit -n 4096

taskprojectfunction() {
  task $1 modify project:$2
}
alias tproj=taskprojectfunction

setopt share_history
setopt histappend
bindkey -v
export KEYTIMEOUT=20
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh


### Aliases for Midway
alias 'start_stats'="ssh twolf@midway2-login1.rcc.uchicago.edu /project2/lgrandi/xenonnt/development/start_jupyter.py --conda_path /project2/lgrandi/Anaconda3/bin/conda --env pax_head"

ssh_stats () {
#ssh -fN -L 15795:10.50.222.160:15795 twolf@dali-login1.rcc.uchicago.edu && open http://localhost:15795/?token=f74ce9bd47b701ca9017105b6c384b6f6077701c9e343e6c
  # sed -i -e 's/dali-login1.rcc.uchicago.edu/midway2-login1.rcc.uchicago.edu/g' $1
  my_command=$(echo $1 | sed 's/dali-login1.rcc.uchicago.edu/midway2-login1.rcc.uchicago.edu/g')
  my_command=$(echo $my_command | sed 's/dali-login2.rcc.uchicago.edu/midway2-login1.rcc.uchicago.edu/g')
  my_command=$(echo $my_command | sed "s/open /open \'/g")
  my_command="$my_command'"

  IFS='&&' # space is set as delimiter
  read -A ADDR <<< "$my_command" # str is read into an array as tokens separated by IFS
  for i in "${ADDR[@]}"; do # access each element of array
      echo $i
      eval "$i"
  done
}
