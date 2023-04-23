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

# TODO: this seems like it needs some cleanup
alias set_custom_system_type="echo $@ >  $CUSTOM_SYSTEM_TYPE_FILE"
alias get_custom_system_type="cat $CUSTOM_SYSTEM_TYPE_FILE"

# TODO: Time how long does loading the bashrc file takes
# if [ ! $BASHRC_LOADED ]; then
  echo -e ".\c"
  source "$HOME/.bashrc"
# fi

if [ -f "$HOME/.cargo/env" ]; then
  source "$HOME/.cargo/env"
fi;

if [ -d "/home/ccolorado/.local/bin" ];
then
  # Created by `pipx` on 2021-09-16 00:03:44
  export PATH="$PATH:/home/ccolorado/.local/bin"
fi

type pyenv &> /dev/null
is_pyenv_installed=$?

if [ $is_pyenv_installed -eq "0" ]; then
  export PYENV_ROOT="$HOME/.pyenv"
  command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
  eval "$(pyenv init -)"
fi;
