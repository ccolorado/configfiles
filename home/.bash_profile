# Sets custom system type as full system by default
# types:
#   full      desktop computer capable to handle heavy plugins
#   server    Some server, should not rely on external resources or binaries ( e.g. ctags )
#   devbox,   Limited resources, use alternatives for plugins or even avoid some of them
#   rpi       Raspberry Pi host. Plan accordingly :)

export CUSTOM_SYSTEM_TYPE_FILE="$HOME/.custom_system_type"
if [ ! -f "$CUSTOM_SYSTEM_TYPE_FILE" ]; then
  echo "minimal" > "$get_custom_system_type"
fi

alias set_custom_system_type="echo $@ >  $CUSTOM_SYSTEM_TYPE_FILE"
alias get_custom_system_type="cat $CUSTOM_SYSTEM_TYPE_FILE"

# Adds path to $PATH if $1 is an existing directoy
# and isn't already added
pathadd() {
  # Taken from https://superuser.com/questions/39751/add-directory-to-path-if-its-not-already-there
  if [ -d "$1" ] && [[ ":$PATH:" != *":$1:"* ]]; then
    PATH="${PATH:+"$PATH:"}$1"
  fi
}

# TODO: Time how long does loading the bashrc file takes
# if [ ! $BASHRC_LOADED ]; then
echo -e ".\c"
# fi

type pyenv &> /dev/null
is_pyenv_installed=$?

if [ $is_pyenv_installed -eq "0" ]; then
  export PYENV_ROOT="$HOME/.pyenv"
  command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
  eval "$(pyenv init -)"
fi;

export CAIRO_ROOT="$HOME/.cairo"
if [ -d "$CAIRO_ROOT" ]; then
  export STARKNET_NETWORK=alpha-goerli
  export STARKNET_WALLET=starkware.starknet.wallets.open_zeppelin.OpenZeppelinAccount 
  pathadd "$CAIRO_ROOT/target/release"
fi


pathadd "$HOME/bin"
pathadd "$HOME/.local/bin"
pathadd "$HOME/.config/composer/vendor/bin"
pathadd "$HOME/.gem/ruby/2.4.0/bin"
pathadd "$HOME/.rvm/bin"
pathadd "$HOME/.protostar/dist/protostar"
pathadd "$HOME/.foundry/bin"

source "$HOME/.bashrc"
