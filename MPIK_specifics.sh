# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/lin/twolf/anaconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/lin/twolf/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/home/lin/twolf/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/lin/twolf/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

# MPIK functions
# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"
function set_http_pip {
    export HTTP_PROXY=http://www-cache.mpi-hd.mpg.de:3128
    export HTTPS_PROXY=https://www-cache.mpi-hd.mpg.de:3128
    npm config set proxy http://www-cache.mpi-hd.mpg.de:3128
    npm config set https-proxy http://www-cache.mpi-hd.mpg.de:3128
}

function set_http {
    export HTTP_PROXY=www-cache.mpi-hd.mpg.de:3128
    export HTTPS_PROXY=www-cache.mpi-hd.mpg.de:3128
    # npm config set proxy www-cache.mpi-hd.mpg.de:3128
    # npm config set https-proxy www-cache.mpi-hd.mpg.de:3128
    npm config set proxy http://www-cache.mpi-hd.mpg.de:3128
    npm config set https-proxy http://www-cache.mpi-hd.mpg.de:3128
}

set_http

# set up ROOT
source ~/root_v6.20.04/bin/thisroot.sh
alias root='root -l'


# set up HeXe data processor
export LD_LIBRARY_PATH="/home/lin/twolf/GasCounter/walpurgisnacht/lib:$LD_LIBRARY_PATH"
export PATH="/home/lin/twolf/GasCounter/walpurgisnacht/bin:$PATH"

export EDITOR=vim

alias mux=tmuxinator
alias ta='tmux attach'
# alias pip="set_http_pip; pip"

function pip3() {
  set_http_pip
  pip "$@"
  set_http
}


export PATH="$PATH:$HOME/.rvm/bin"
