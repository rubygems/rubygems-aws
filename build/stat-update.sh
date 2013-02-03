#!/bin/bash -e
#
# Build Nginx from source, and wrap it up with fpm
#
# Author: <adam@opscode.com>
#
# This script works on Ubuntu, and maybe on Debian.

set -v

rm -rf stat-update tmp

sudo apt-get install ragel

git clone git://github.com/rubygems/stat-update.git

mkdir -p tmp/usr/local/bin/
mkdir -p tmp/etc/service/stat-update

cd stat-update

git submodule init
git submodule update

make

strip -g stat-update
cp stat-update ../tmp/usr/local/bin
cp runit/run ../tmp/etc/service/stat-update/

cd ../
bundle exec fpm -s dir -t deb \
  -n stat-update -v 1.0.0 --iteration 1 \
  -C tmp \
  .

