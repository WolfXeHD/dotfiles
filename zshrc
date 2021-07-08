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
export CLICOLOR=1
export LSCOLORS=exfxcxdxbxegedabagacad

fpath=(/usr/local/share/zsh-completions $fpath)

# export LD_LIBRARY_PATH=$ROOTSYS/lib:$PYTHONDIR/lib:$LD_LIBRARY_PATH
# export PYTHONPATH=$ROOTSYS/lib:$PYTHONPATH
export PATH=/usr/local/bin:/usr/local/sbin:$PATH
export PATH=/Users/twolf/Physics/UsefulTools/gallery:$PATH

# source /usr/local/opt/root/bin/thisroot.sh
#
function lectures()
{
  cd /Users/twolf/Physics/Lectures
  open $("fzf")
}

function o()
{
  open $("fzf")
}



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

export EDITOR='vim'
export VISUAL='vim'
source ~/.bin/tmuxinator.zsh

ulimit -n 4096

#aliases
alias ll="ls -ltrha"
alias skim='/Applications/Skim.app/Contents/MacOS/Skim'
alias root="root -l"
alias wget_arxiv="wget --user-agent=\"Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/51.0.2704.103 Safari/537.36\""
alias straxlab='ssh twolf@dali-login1.rcc.uchicago.edu /project2/lgrandi/xenonnt/development/start_jupyter.py'


# taskwarrior aliases
alias tl='task list'
alias ta='task add $1'
alias tm='task $1 modify '
alias te='task $1 edit'
alias tlw='task -private list'

# todo.txt aliases
alias t="todo.sh"


taskprojectfunction() {
  task $1 modify project:$2
}
alias tproj=taskprojectfunction

setopt share_history
setopt histappend
bindkey -v
export KEYTIMEOUT=20
# export HTTP_PROXY=www-cache.mpi-hd.mpg.de:3128¬
# export HTTPS_PROXY=www-cache.mpi-hd.mpg.de:3128¬

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

### Aliases for Midway
# alias 'start_stats'="ssh twolf@midway2-login1.rcc.uchicago.edu /project2/lgrandi/xenonnt/development/start_jupyter.py --conda_path /project2/lgrandi/Anaconda3/bin/conda --env pax_head"
alias 'start_stats'="ssh twolf@dali2 /project2/lgrandi/xenonnt/development/start_jupyter.py --conda_path /project2/lgrandi/Anaconda3/bin/conda --env pax_head"

ssh_stats () {
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


export PATH="/usr/local/opt/python@3.9/bin:$PATH"
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi
export PATH="/usr/local/opt/ruby/bin:$PATH"
export PATH="/Users/twolf/.rbenv/versions/2.3.4/bin:$PATH"


if [ -f "$HOME/mysoftware/nvim.appimage" ]
then
  alias vim="$HOME/mysoftware/nvim.appimage"
fi

here=`hostname`

if [ $here = "lin-1909a" ]
then
  source ~/.MacOS_specifics.sh
fi
