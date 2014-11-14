#!/bin/bash

source ~/.build_settings
set -e
cd $_BUILD_TARGET_DOWNLOAD

if [ ! -f vim-7.4.tar.bz2 ]; then
  wget ftp://ftp.vim.org/pub/vim/unix/vim-7.4.tar.bz2 -q
fi
sudo yum -q -y install ncurses-devel python-devel
tar -xf vim-7.4.tar.bz2 -C $_BUILD_TARGET_MAKE
cd $_BUILD_TARGET_MAKE/vim74

./configure \
    --prefix=$HOME/.local/ \
    --with-features=huge \
    --enable-gpm \
    --enable-acl \
    --with-x=no \
    --disable-gui \
    --enable-multibyte \
    --enable-cscope \
    --enable-pythoninterp \
    --disable-rubyinterp \
    --disable-luainterp > /dev/null

make  > /dev/null
sudo make install > /dev/null
cd ..

#Enabling python for debugging
#    --disable-pythoninterp \
#    --disable-python3interp \
