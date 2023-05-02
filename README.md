configfiles
===========

Dot files for my linux set up

Installation
============
To install the configfiles to ~/.configfiles do:
```bash

git clone https://github.com/ccolorado/configfiles ~/configfiles

bash ~/configfiles/bin/binder
bash ~/configfiles/bin/devenv # optional for really confy system

vim +PluginInstall +qall
```

Test Setup
==========
# Build Image;
`docker build --no-cache -t config:test .`
# Run instance;
`docker run -it --name config_container -v ./:/configfiles config:test`
