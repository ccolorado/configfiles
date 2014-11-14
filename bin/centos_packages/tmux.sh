#!/bin/bash

set -e
set -x
#if [ -f ~/.build_settings ]; then
#  source ~/.build_settings
#fi;

_BUILD_TARGET_DOWNLOAD=${_BUILD_TARGET_DOWNLOAD-/tmp/build/download}
_BUILD_TARGET_MAKE=${_BUILD_TARGET_MAKE-/tmp/build/make}

mkdir -p $_BUILD_TARGET_DOWNLOAD $_BUILD_TARGET_MAKE
cd $_BUILD_TARGET_DOWNLOAD

if [ ! -f libevent-2.0.21-stable.tar.gz ]; then
  wget "https://github.com/downloads/libevent/libevent/libevent-2.0.21-stable.tar.gz" -q
fi;
if [ ! -f tmux-1.8.tar.gz ]; then
  wget "http://downloads.sourceforge.net/project/tmux/tmux/tmux-1.8/tmux-1.8.tar.gz"  -q
fi;

tar -xf libevent-2.0.21-stable.tar.gz -C $_BUILD_TARGET_MAKE/
tar -xf tmux-1.8.tar.gz -C $_BUILD_TARGET_MAKE/

sudo yum -q -y install gcc kernel-devel make ncurses-devel

cd $_BUILD_TARGET_MAKE/libevent-2.0.21-stable
./configure --prefix=/usr/local > /dev/null
#./configure --prefix=$HOME/.local/ > /dev/null
make > /dev/null
sudo make install  > /dev/null
cd ..

if [ ! -f "$HOME/.local/bin/tmux" ]; then
  cd $_BUILD_TARGET_MAKE/tmux-1.8
  #LDFLAGS="-L/usr/local/lib -Wl,-rpath=/usr/local/lib" ./configure --prefix=/usr/local
  LDFLAGS="-L/usr/local/lib -Wl,-rpath=/usr/local/lib" ./configure --prefix=$HOME/.local/
  make > /dev/null
  sudo make install > /dev/null
fi;
cd ..
