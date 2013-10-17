str2color()
{
    [ -z "$1" ] && return
    hex=$(echo -n "$1" |md5sum| head -c 2)
    printf "\e[48;5;0m\e[38;5;%dm" 0x$hex
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
export hostcolor=$(str2color $HOSTNAME)
export HC=$hostcolor
export distro_flag=$( distroPromptFlag )

#export PS1='[$?]\033[0;36m[\u@'$HC'\h\033[0;36m \W]\$ \[\033[0m\]'
export PS1='[$?]'$distro_flag"$PROMPT_USER_COLOR[\u@$HC\h$PROMPT_USER_COLOR \W]$CLEAR\$ "
if [ "root" = $(whoami) ];
then
    #export PS1='[$?]\033[1;31m[\u@'$HC'\h\033[1;31m \W]\# \[\033[0m\]'
    export PS1='[$?]'$distro_flag"$PROMPT_ROOT_COLOR[\u@$HC\h$PROMPT_ROOT_COLOR \W]$CLEAR\# "
fi;

alias ls='ls --color=auto -p'
alias removespaces='for f in *\ *; do mv -- "$f" "${f// /_}"; done'
alias grep="grep --color=auto"
alias cp='cp -v'
alias mv='mv -v'
alias rm='rm -v'
alias svim='sudo vim'
alias svimdiff='sudo vimdiff'
alias mysql='mysql --auto-rehash'
alias sshmount='sshfs -o reconnect -o follow_symlinks'
alias tmux='tmux -2'
alias whitenoise='mplayer -nocache -playlist ~/.white_noise_playlist -loop 0 -shuffle -softvol -quiet'
alias reboot='sudo systemctl reboot'
alias shutdown='sudo systemctl poweroff'

# Host completion for ssh and scp for non archlinux hosts
# TODO validate 'complete' exists
if [ ! -f /etc/arch-release ];
then
  complete -W  "$(grep '^Host' ~/.ssh/config | awk '{print $2}')" ssh scp
  complete -W  "$(cat ~/.ssh/known_hosts | cut -f 1 -d ' ' | sed -e s/,.*//g | grep -v ^# | sort |uniq | grep -v '\[' )" ssh scp
fi

mkdir -p ~/bin
export PATH=$PATH":~/bin"
# Include host specific bashrc
if [ -f ~/.extra_bashrc ];
then
    source ~/.extra_bashrc
fi
export TERM=xterm-256color
