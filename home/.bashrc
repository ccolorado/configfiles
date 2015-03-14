str2color()
{
    [ -z "$1" ] && return
    if [ "darwin14" = $OSTYPE ];
    then
        hex=$(echo -n "$1" |md5| head -c 2)
    else
        hex=$(echo -n "$1" |md5sum| head -c 2)
    fi;
    printf "\e[48;5;0m\e[38;5;%dm" 0x$hex
}

# Bypass Ctrl+s default behaivour under vim
vim()
{
    local STTYOPTS="$(stty --save)"
    stty stop '' -ixoff
    command vim "$@"
    stty "$STTYOPTS"
}

# Colors and prompts
PROMPT_USER_COLOR="\[\033[40;0;36m\]"
PROMPT_ROOT_COLOR="\[\033[40;1;31m\]"
CLEAR="\[\033[0m\]"
distroPromptFlag()
{
    distro_flag="";
    ARCH_FLAG="\[\033[40;1;34m\]A$CLEAR"
    CENT_FLAG="\[\033[40;1;33m\]C$CLEAR"
    SUSE_FLAG="\[\033[40;1;32m\]S$CLEAR"
    FEDO_FLAG="\[\033[40;1;34m\]F$CLEAR"
    GENT_FLAG="\[\033[40;1;35m\]g$CLEAR"
    REDH_FLAG="\[\033[40;1;31m\]R$CLEAR"
    DBIN_FLAG="\[\033[40;1;31m\]@$CLEAR"
    DRWN_FLAG="\[\033[40;1;37m\]ć$CLEAR"
    if [ -f /etc/centos-release ];
    then
      distro_flag=$CENT_FLAG;
    fi
    #archliux distroflag
    if [ -f /etc/arch-release ];
    then
        distro_flag=$ARCH_FLAG
    fi
    #osx distroflag
    if [ "darwin12" = $OSTYPE ];
    then
        distro_flag=$DRWN_FLAG;
    fi;
    echo $distro_flag;
}


get_branching_out_commit (){

  current_branch=$(git rev-parse --abbrev-ref HEAD)
  origin_branch=${DEFAULT_GIT_BRANCH-'master'}
  origin_branch=${1-$origin_branch}
  echo "git merge-base $origin_branch $current_branch" 1>&2
  echo `git merge-base $origin_branch $current_branch`
}

# Setting up PS1 value
export EDITOR=vim
export hostcolor=$(str2color $HOSTNAME)
export HC='\[$hostcolor\]'
export distro_flag=$( distroPromptFlag )

IS_SSH_SESSION=""
if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ]; then
  IS_SSH_SESSION="\[\033[40;1;33m\]!$CLEAR"
else
  #Muting output when performed over ssh to avoid choking the connection
  alias cp='cp -v'
  alias mv='mv -v'
  alias rm='rm -v'
fi;

#   Setting User color and user symbol ( $ for users and # for root)
_USER_COLOR=$PROMPT_USER_COLOR
_USER_SYMBL='$'
if [ "root" = $(whoami) ];
then
  _USER_COLOR=$PROMPT_ROOT_COLOR
  _USER_SYMBL='#'
fi;
export PS1='[$?]'"$distro_flag(${SHLVL}:\j)$IS_SSH_SESSION$_USER_COLOR[\u@$HC\h$_USER_COLOR \w]\n$_USER_SYMBL $CLEAR"

alias ls='ls --color=auto -p'
alias removespaces='for f in *\ *; do mv -- "$f" "${f// /_}"; done'
alias grep="grep --color=auto"
alias svim='sudoedit'
alias svimdiff='sudo vimdiff'
alias mysql='mysql --auto-rehash'
alias sshmount='sshfs -o reconnect -o follow_symlinks'
alias tmux='tmux -2'
alias whitenoise='mplayer -nocache -playlist ~/.white_noise_playlist -shuffle -softvol -quiet  volume=20 -loop 0 '

command -v systemctl  >/dev/null 2>&1 && alias reboot='sudo systemctl reboot'
command -v systemctl  >/dev/null 2>&1 && alias shutdown='sudo systemctl poweroff'

#Adding ~/bin directory to PATH
mkdir -p ~/bin
export PATH=$PATH":~/bin"

#python virtualenv settings
mkdir -p ~/.virtualenvs

if [ -f /usr/bin/virtualenvwrapper.sh ]; then
  source /usr/bin/virtualenvwrapper.sh
fi

# Include host specific bashrc
if [ -f ~/.extra_bashrc ];
then
    source ~/.extra_bashrc
fi

export TERM=xterm-256color
