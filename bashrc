# .bashrc

shopt -s expand_aliases

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# User specific aliases and functions

[ -f $HOME/.fzf.bash ] && source $HOME/.fzf.bash

alias ll="ls -ltrha"
alias root='root -b'
alias ta='tmux attach'

# export PATH="/project2/lgrandi/anaconda3/bin:$PATH"
export PATH="/cvmfs/xenon.opensciencegrid.org/releases/anaconda/2.4/bin:$PATH"
export PATH="/home/twolf/.nvim_installation/nvim-linux64/bin:$PATH"
export PATH="/home/twolf/gallery:$PATH"
export PATH="/home/twolf/.local/bin:$PATH"
export PATH="/home/twolf/.gem/ruby/2.6.0/bin:$PATH"


# export PATH=/project2/lgrandi/anaconda3/bin:$PATH # This path was discussed in the computing gitter on 04/09/19 as the new path, not yet supported

alias qstatq='qstat -u twolf'
alias squeueq='squeue -u twolf'
export HISTCONTROL=ignoreboth:erasedups:ignoredups

if command -v module &> /dev/null
then
  module load tmux
  module load vim/8.1
fi


# Old notebook submission
function Jupyter_batch()
{
  cd
  # export PATH="/project2/lgrandi/anaconda3/bin:$PATH"
  export PATH="/cvmfs/xenon.opensciencegrid.org/releases/anaconda/2.4/bin:$PATH"
  #source activate pax_head --version 6.8.0
  if [ ! -d logs ]
  then
    mkdir logs
  fi

  source activate pax_head
  sbatch /project2/lgrandi/notebook.sh
  cd -
}

# Old notebook submission
function Jupyter_batch_dali()
{
  cd
  export PATH="/cvmfs/xenon.opensciencegrid.org/releases/anaconda/2.4/bin:$PATH"
  #source activate pax_head --version 6.8.0
  if [ ! -d logs ]
  then
    mkdir logs
  fi

  source activate pax_head
  sbatch ~/.dali_submission.sh
  cd -
}

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# compatability with dotbot
export PATH="$HOME/mysoftware/bin:$PATH"

if [ -f "$HOME/mysoftware/nvim.appimage" ]
then
  alias vim="$HOME/mysoftware/nvim.appimage"
fi




here=`hostname`
if [  $here == "leibniz" ]
then
  source ~/.MPIK_specifics.sh
fi
