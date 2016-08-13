configfiles
===========

Configuration files for multiple applications 

Primarily containing Linux applications configuration files

Installation
============
To install the configfiles to ~/.configfiles do:
>git clone https://github.com/ccolorado/configfiles ~/.configfiles  
>cd .configfiles/
>git submodule init
>git submodule update
>bash ~/.configfiles/bin/binder

Todo
====
* Integrate `github.com/mandre/tmux-mem-cpu`
* Sort vimrc
* add exclude rules for svn git for grep.vim
* Review solution for "dynamically" loading changes to the bash config  sounds super convenient but also like a bad idea
  https://www.quora.com/How-do-I-update-my-bashrc-across-all-the-open-panes-windows-in-tmux
