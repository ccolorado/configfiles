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
    UBNT_FLAG="\[\033[1;33;45m\]U$CLEAR"

    #if [ -f "/etc/lsb-release" ] || [ 0 -eq $(grep --quiet -i ubuntu /etc/lsb-release) ];
    #then
    #  distro_flag=$UBNT_FLAG;
    #fi;

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
  for word in "$@"
  do
    query=$query".?"$word
  done

  query=${query//_/\.\?}
  echo $query".?"

}

feature_hunt(){
  expression=$(feature_hunt_expression "$@")

  echo "looking for $@ => $expression"
  type ag > /dev/null
  is_ag_installed=$?
  if [ $is_ag_installed -eq "0" ]; then
    ag $expression
  else
    egrep -rni "$expression" * --exclude="tags"
  fi;

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

#Arch git completion script
if [ -f '/usr/share/git/completion/git-prompt.sh' ]; then
  git_completion_script='/usr/share/git/completion/git-prompt.sh'
fi;

#Ubuntu git completion script
if [ -f '/etc/bash_completion.d/git-prompt' ]; then
  git_completion_script='/etc/bash_completion.d/git-prompt'
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

export PS1='[$?]'"\@ $distro_flag(${SHLVL}:\j)$IS_SSH_SESSION$_USER_COLOR[\u@$HC\h$_USER_COLOR \w]""\n$_USER_SYMBL $CLEAR"

# Do not include bash_prompt if completion script if completion function  can't be found
if [ `type -t __git_ps1`"" == 'function' ]; then
  export PS1='[$?]'" \@ $distro_flag(${SHLVL}:\j)$IS_SSH_SESSION$_USER_COLOR[\u@$HC\h$_USER_COLOR \w]"'$(__git_ps1 "( ⭠ %s )")'"\n$_USER_SYMBL $CLEAR"
fi;

alias ls='ls --color=auto -p'
alias ll='ls -alh'
alias removespaces='for f in *\ *; do mv -- "$f" "${f// /_}"; done'
alias grep="grep --color=auto"
alias svim='sudoedit'
alias svimdiff='sudo vimdiff'
alias mysql='mysql --auto-rehash'
alias sshmount='sshfs -o reconnect -o follow_symlinks'
alias tmux='tmux -2'
alias whatsmyip="dig +short myip.opendns.com @resolver1.opendns.com"
alias youtube-dl="youtube-dl -t "
alias yt-audio="youtube-dl --extract-audio --audio-format mp3 "

# vagrant aliases
# next will use containers/docker

alias vsh="vagrant ssh"
alias vup="vagrant up"
alias vrl="vagrant reload"
alias vdown="vagrant halt"
alias vkill="vagrant destroy -f"


# Typos
# =====
# I should really take a look at zsh
alias gti="git"


# Custom system type switching
export CUSTOM_SYSTEM_TYPE_FILE="$HOME/.custom_system_type"
alias set_custom_system_type="echo $@ >  $CUSTOM_SYSTEM_TYPE_FILE"
alias get_custom_system_type="cat $CUSTOM_SYSTEM_TYPE_FILE"

command -v ccze  >/dev/null 2>&1 && CCZE_DECORATOR="| ccze -A"

alias tlogs='sudo find /var/log/httpd/ -iname "*log" | xargs sudo  tail -f '$CCZE_DECORATOR
alias tlogs_errors='sudo find /var/log/httpd/ -iname "*error**log" | xargs sudo tail  -f | sed -u "s/\\\n/\\n/g" | sed -u "s/\\\t/\\t/g" '$CCZE_DECORATOR;
alias tlogs_access='sudo find /var/log/httpd/ -iname "*access*log" | xargs sudo  tail -f | sed -u "s/\\\n/\\n/g" | sed -u "s/\\\t/\\t/g" '$CCZE_DECORATOR;

if [ -f ~/.white_noise_playlist ]; then
  alias whitenoise='mplayer -nocache -playlist ~/.white_noise_playlist -shuffle -softvol -quiet  volume=20 -loop 0 '
fi;

#stop bash flow control for ^s
stty stop ^e
stty start ^b

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
unset SSH_ASKPASS

if [ -d /home/vagrant/.config/composer/vendor/bin ]; then
  PATH=$PATH":/home/vagrant/.config/composer/vendor/bin"
fi;
