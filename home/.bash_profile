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
if [ ! $BESHRC_LOADED ]; then
  echo -e ".\c"
  source "$HOME/.bashrc"
fi

