#!/bin/bash

set -e
source ~/.build_settings
cd $_BUILD_TARGET_DOWNLOAD

if [ ! -f realpath-1.17-1.el6.rf.i686.rpm ]; then
  wget -q http://apt.sw.be/redhat/el6/en/i386/rpmforge/RPMS/realpath-1.17-1.el6.rf.i686.rpm

fi;

sudo yum -y -q install $_BUILD_TARGET_DOWNLOAD/realpath-1.17-1.el6.rf.i686.rpm
