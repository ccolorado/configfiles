str2color()
{
    [ -z "$1" ] && return
    if [[ $OSTYPE  == darwin* ]];
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

# Taken from:
# https://unix.stackexchange.com/questions/6463/find-searching-in-parent-directories-instead-of-subdirectories
upfind () {
  path=$(pwd)
  while [[ "$path" != "" && ! -e "$path/$1" ]]; do
    path=${path%/*}
  done
  echo "$path/"$1
}

set -o vi
bind "\C-l":clear-screen

export NOTES_HOME=~/Notes/src

# Colors and prompts
PROMPT_USER_COLOR="\[\033[40;0;36m\]"
PROMPT_ROOT_COLOR="\[\033[40;1;31m\]"
PROMPT_GIT_COLOR="\[\033[40;1;33m\]"
PROMPT_WARN_COLOR="\[\033[40;1;11m\]"
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
    UBNT_FLAG="\[\033[1;33;45m\]U$CLEAR"

    if [ -f "/etc/lsb-release" ];
    then
      grep --quiet -i ubuntu "/etc/lsb-release"
      is_ubuntu_in_lsb_release=$?
      if [ 0 -eq $is_ubuntu_in_lsb_release ];
      then
        distro_flag=$UBNT_FLAG;
      fi
    fi;

    if [ -f "/etc/centos-release" ];
    then
      distro_flag=$CENT_FLAG;
    fi

    #archliux distroflag
    if [ -f "/etc/arch-release" ];
    then
        distro_flag=$ARCH_FLAG
    fi

    #osx distroflag
    if [[ $OSTYPE == darwin* ]];
    then
        distro_flag=$DRWN_FLAG;
    fi;

    echo $distro_flag;
}

git_get_branching_out_commit (){

  current_branch=$(git rev-parse --abbrev-ref HEAD)
  origin_branch=${DEFAULT_GIT_BRANCH-'master'}
  origin_branch=${1-$origin_branch}
  echo "git merge-base $origin_branch $current_branch" 1>&2
  echo `git merge-base $origin_branch $current_branch`
}

git_get_last_pushed_commit (){

  origin_branch=${DEFAULT_GIT_BRANCH-'master'}
  origin_branch=${1-$origin_branch}
  echo "git rev-parse origin/$origin_branch" 1>&2
  echo `git rev-parse origin/$origin_branch`
}

feature_hunt_expression (){
  query=""
  if [ "$1" = "-e" ]; then
    shift
    query="${*:1}"
    echo $query
    query="${query//-e}"
    query="${query// / }"
  else
    for word in "$@"
    do
      query=$query".?"$word
    done

    query=${query//_/\.\?}".?"
  fi

  echo $query;

}

feature_hunt(){

  expression=$(feature_hunt_expression "$@")

  IS_REGEX=false
  GREP_FLAG=""
  if [ "$1" = "-e" ]; then
    IS_REGEX=true
    GREP_FLAG="-E"
    echo "looking for REGEX $@ => $expression"
    expression="\"$expression\"";
  else
    echo "looking for $@ => $expression"
  fi

  type ag > /dev/null
  is_ag_installed=$?
  if [ $is_ag_installed -eq "0" ]; then
    cmd="ag $expression"
  else
    cmd="grep -rni $GREP_FLAG "$expression" * --exclude="tags""
  fi;

  echo Running: $cmd
  eval $cmd

}

# TODO check vnsearch works correctly
vnsearch(){
  cd $NOTES_HOME
  feature_hunt $@
  cd -
}

kernel_needs_reload(){

  kernel_needs_reboot=""
  pacman_ver=""
  uname_ver=$(uname -r | sed -e 's/-ARCH//g' | sed -e 's/-arch/.arch/g')

  if [ -f /tmp/.kernel_needs_reboot ]; then
    kernel_needs_reboot="+"
  else

    type pacman > /dev/null 2>&1

    if [ $? -eq 0 ]; then
      pacman_ver=$(pacman -Q linux 2> /dev/null | sed -e 's/linux //gi')
    else
      return 0
    fi

    if [ "$pacman_ver" != "" ]
    then

      if [ "$pacman_ver" != "$uname_ver" ]
      then
        kernel_needs_reboot="$pacman_ver > $uname_ver"
        echo $kernel_needs_reboot > /tmp/.kernel_needs_reboot
        $kernel_needs_reboot = "+"
      fi;

    fi;

  fi;
  echo $kernel_needs_reboot
}

# Setting up PS1 value
export EDITOR=vim
export hostcolor=$(str2color $HOSTNAME)
export HC='\[$hostcolor\]'
export distro_flag=$( distroPromptFlag )

# Bash history tweaking
export HISTSIZE=10000
PROMPT_COMMAND='history -a'
shopt -s histappend
export HISTIGNORE="ls:ps:history:smplayer"
export HISTCONTROL=ignoreboth


IS_SSH_SESSION=""

#   Setting User color and user symbol ( $ for users and # for root)
_USER_COLOR=$PROMPT_USER_COLOR
_USER_SYMBL='$'
if [ "root" = $(whoami) ];
then
  _USER_COLOR=$PROMPT_ROOT_COLOR
  _USER_SYMBL='#'
fi;

#Arch git completion script
if [ -f '/usr/share/git/completion/git-prompt.sh' ]; then
  git_completion_script='/usr/share/git/completion/git-prompt.sh'
fi;

#Ubuntu git completion script
if [ -f '/etc/bash_completion.d/git-prompt' ]; then
  git_completion_script='/etc/bash_completion.d/git-prompt'
fi;

#OSX git completion script
if [ -f '/usr/local/etc/profile.d/bash_completion.sh' ]; then
  git_completion_script='/usr/local/etc/profile.d/bash_completion.sh'
fi;

#Apply git completion if found
if [ -f "$git_completion_script" ]; then

  source "$git_completion_script"
  GIT_PS1_SHOWDIRTYSTATE=1
  GIT_PS1_SHOWUNTRACKEDFILES=1
  GIT_PS1_SHOWUNTRACKEDFILES=1
  GIT_PS1_SHOWUPSTREAM=1
  GIT_PS1_SHOWUPSTREAM='auto'

fi;

export PS1='[$?]$( kernel_needs_reload )'" \A $distro_flag(${SHLVL}:\j)$IS_SSH_SESSION$_USER_COLOR[\u@$HC\h$_USER_COLOR \w]""\n$_USER_SYMBL $CLEAR"

# Do not include bash_prompt if completion script if completion function  can't be found
if [ `type -t __git_ps1`"" == 'function' ]; then
  export PS1='[$?]$( kernel_needs_reload )'" \A $distro_flag(${SHLVL}:\j)$IS_SSH_SESSION$_USER_COLOR[\u@$HC\h$_USER_COLOR \w]"$PROMPT_GIT_COLOR'$(__git_ps1 " (⭠ %s)")'"$_USER_COLOR \n$_USER_SYMBL $CLEAR"
fi;


# Typos
# =====
# I should really take a look at zsh

# Custom system type switching
export CUSTOM_SYSTEM_TYPE_FILE="$HOME/.custom_system_type"
export BASHRC_LOADED=1
alias set_custom_system_type="echo $@ >  $CUSTOM_SYSTEM_TYPE_FILE"
alias get_custom_system_type="cat $CUSTOM_SYSTEM_TYPE_FILE"

command -v ccze  >/dev/null 2>&1 && CCZE_DECORATOR="| ccze -A"

if [ -f ~/.white_noise_playlist ]; then
  alias whitenoise='mplayer -nocache -loop 0 -shuffle $(cat ~/.white_noise_playlist)  -volume 20 -quiet'
fi;

#stop bash flow control for ^s
stty stop ^e
stty start ^b

command -v systemctl  >/dev/null 2>&1 && alias reboot='sudo systemctl reboot'
command -v systemctl  >/dev/null 2>&1 && alias shutdown='sudo systemctl poweroff'

#python virtualenv settings

# mkdir -p ~/.virtualenvs
# export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python

# if [ -f /usr/bin/virtualenvwrapper.sh ]; then

#   source /usr/bin/virtualenvwrapper.sh
# fi

# Include host specific bashrc
if [ -f ~/.extra_bashrc ];
then
    source ~/.extra_bashrc
fi

export TERM=xterm-256color
unset SSH_ASKPASS

# PATH Enhancements

#Adding ~/bin directory to PATH

# Opens a note using vimnote with autocompeltion needs versining vimnote script
complete -C vnoteGPT  vnoteGPT
complete -C vimnote vimnote
complete -C vimexec vimexec


if [ -f "/usr/share/nvm/init-nvm.sh" ]; then
  source /usr/share/nvm/init-nvm.sh
fi

if [ -d "$HOME/.nvm" ]; then
  export NVM_DIR="$HOME/.nvm"
fi

if [ -f "$HOME/.aliases" ]; then
  source "$HOME/.aliases"
fi

if [ -f "/usr/local/opt/nvm/nvm.sh" ]; then
  export NVM_DIR="/usr/local/opt/nvm"
fi

[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

if [ -f "$HOME/.extra_aliases" ]; then
  source "$HOME/.extra_aliases"
fi;

[[ -r "/usr/local/etc/profile.d/bash_completion.sh" ]] && . "/usr/local/etc/profile.d/bash_completion.sh"
[ -r "/usr/local/etc/bash_completion" ] && . /usr/local/etc/bash_completion

# OSX docker cli completion
if [[ $OSTYPE == darwin* ]];
then
  if [ ! -L "$(brew --prefix)/etc/bash_completion.d/docker" ]; then
    etc=/Applications/Docker.app/Contents/Resources/etc
    ln -s $etc/docker.bash-completion $(brew --prefix)/etc/bash_completion.d/docker
    ln -s $etc/docker-machine.bash-completion $(brew --prefix)/etc/bash_completion.d/docker-machine
    ln -s $etc/docker-compose.bash-completion $(brew --prefix)/etc/bash_completion.d/docker-compose
  fi
fi

mkdir -p ~/bin
