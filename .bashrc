[ -f ~/.fzf.bash ] && source ~/.fzf.bash
. ~/git-completion.bash
. ~/git-prompt.sh

# colors
GREEN='\e[0;32m\]'
B_GREEN='\e[1;32m\]'
MAGENTA='\e[0;35m\]'
B_MAGENTA='\e[1;35m\]'
YELLOW='\e[0;33m\]'
B_YELLOW='\e[1;33m\]'
RED='\e[0;31m'
BLUE='\e[0;34m'
B_BLUE='\e[1;34m'
CYAN='\e[0;36m\]'
B_CYAN='\e[1;36m\]'
COLOR_END='\[\033[0m\]'

WORKING_DIRECTORY_PATH='\w'
GIT_BRANCH='$(__git_ps1 " (%s)")'

export GIT_PS1_SHOWDIRTYSTATE=1
export PS1="\n${CYAN}${WORKING_DIRECTORY_PATH}${GREEN}${GIT_BRANCH}${MAGENTA}\n❯${COLOR_END} "

# ls to colorize
export LSCOLORS=gxFxBxDxCxegedabagacad
alias ls='ls -GF'
alias ll='ls -alh'
