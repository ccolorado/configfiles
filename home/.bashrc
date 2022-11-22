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
# Taken http://brettterpstra.com/2015/02/20/shell-trick-printf-rules/
rule () {
    printf -v _hr "%*s" $(tput cols) && echo ${_hr// /${1--}}
}

# Taken from https://superuser.com/questions/39751/add-directory-to-path-if-its-not-already-there
pathadd() {
   if [ -d "$1" ] && [[ ":$PATH:" != *":$1:"* ]]; then
       PATH="${PATH:+"$PATH:"}$1"
   fi
}

set -o vi
bind "\C-l":clear-screen

export NOTES_HOME=~/Notes

# Colors and prompts
PROMPT_USER_COLOR="\[\033[40;0;36m\]"
PROMPT_ROOT_COLOR="\[\033[40;1;31m\]"
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

    if [ -f "/etc/lsb-release" ] || [ 0 -eq $(grep --quiet -i ubuntu /etc/lsb-release) ];
    then
      distro_flag=$UBNT_FLAG;
    fi;
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

vnsearch(){
  cd ~/Notes/
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
      pacman_ver=$(pacman -Q linux | sed -e 's/linux //gi')
    else
      return 0
    fi

    if [ $pacman_ver != "" ]
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
  export PS1='[$?]$( kernel_needs_reload )'" \A $distro_flag(${SHLVL}:\j)$IS_SSH_SESSION$_USER_COLOR[\u@$HC\h$_USER_COLOR \w]"'$(__git_ps1 "( ⭠ %s )")'"\n$_USER_SYMBL $CLEAR"
fi;

alias ls='ls --color=auto -p'
alias ll='ls -alh'
alias cp='cp -iv'
alias removespaces='for f in *\ *; do mv -- "$f" "${f// /_}"; done'
alias grep="grep --color=auto"
alias svim='sudoedit'
alias svimdiff='sudo vimdiff'
alias mysql='mysql --auto-rehash'
alias sshmount='sshfs -o reconnect -o follow_symlinks'
alias tmux='tmux -2'
alias whatsmyip="dig +short myip.opendns.com @resolver1.opendns.com"
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
export BASHRC_LOADED=1
alias set_custom_system_type="echo $@ >  $CUSTOM_SYSTEM_TYPE_FILE"
alias get_custom_system_type="cat $CUSTOM_SYSTEM_TYPE_FILE"

command -v ccze  >/dev/null 2>&1 && CCZE_DECORATOR="| ccze -A"

alias tlogs='sudo find /var/log/httpd/ -iname "*log" | xargs sudo  tail -f '$CCZE_DECORATOR
alias tlogs_errors='sudo find /var/log/httpd/ -iname "*error**log" | xargs sudo tail  -f | sed -u "s/\\\n/\\n/g" | sed -u "s/\\\t/\\t/g" '$CCZE_DECORATOR;
alias tlogs_access='sudo find /var/log/httpd/ -iname "*access*log" | xargs sudo  tail -f | sed -u "s/\\\n/\\n/g" | sed -u "s/\\\t/\\t/g" '$CCZE_DECORATOR;

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
mkdir -p ~/bin
pathadd "$HOME/bin"
pathadd "$HOME/.config/composer/vendor/bin"
pathadd "$HOME/.gem/ruby/2.4.0/bin"

# Opens a note using vimnote with autocompeltion needs versining vimnote script
complete -C vimnote vimnote
complete -C vimexec vimexec
# Reload Bash configuration
alias rld="source ~/.bashrc"
# Opens irc session on personal server
alias irc_screen='ssh -t chalupa "screen -ls | grep irc; if [ \$? -eq 0 ]; then screen -dRR irc; else screen -U -S irc; fi"'
# TODO make gitstatusticker trigger on file changes
# alias gitstatusticker="watch -n5 -t -d -c 'git -c color.ui=always status -s; printf \"\\n\n\"; date ; git ls-files -v | grep -E \"^[a-z]\";date '"
alias gs="git status"
alias grr="git restore --staged"
alias gd="git diff"
alias gcam="git commit --amend -v"
alias gdiff="git diff"
alias gres="git restore --staged"
alias gad="git add"
alias gl="git log"
alias webcam_disble_autofocues="uvcdynctrl -v -d video0 --set='Focus, Auto' 0"
alias fastTest="tcompile && clear && truffle test --migrations_directory ./test/ --debug"

if [ -d "$HOME/.nvm" ]; then
  export NVM_DIR="$HOME/.nvm"
fi

if [ -f "$HOME/.alias" ]; then
  source "$HOME/.alias"
fi

if [ -f "/usr/local/opt/nvm/nvm.sh" ]; then
  export NVM_DIR="/usr/local/opt/nvm"
fi

[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

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

if [ -f "$HOME/.cargo/env" ]; then
  source "$HOME/.cargo/env"
fi

# PATH extensions
# Created by `pipx` on 2021-09-16 00:03:44
if [ -d "$HOME/.local/bin" ]; then
  export PATH="$PATH:$HOME/.local/bin"
fi
if [ -d "$HOME/.foundry/bin" ]; then
  export PATH="$PATH:$HOME/.foundry/bin"
fi
