#!/bin/bash

set -e
source ~/.build_settings
cd $_BUILD_TARGET_DOWNLOAD

if [ ! -f ccze-0.2.1-6.el6.x86_64.rpm ]; then
  wget http://dl.fedoraproject.org/pub/epel/6/x86_64/ccze-0.2.1-6.el6.x86_64.rpm -q
fi

sudo yum -q -y install $_BUILD_TARGET_DOWNLOAD/ccze-0.2.1-6.el6.x86_64.rpm
