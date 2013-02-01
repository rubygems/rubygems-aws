#!/bin/bash -e
#
# Build Nginx from source, and wrap it up with fpm
#
# Author: <adam@opscode.com>
#
# This script works on Ubuntu, and maybe on Debian.

# Tweak the version and the md5sum for new releases of nginx
NGINX_VERSION="1.2.6"
NGINX_MD5SUM="1350d26eb9b66364d9143fb3c4366ab6"

##
# This stuff should all be automatic...
##
NGINX_FILENAME="nginx-${NGINX_VERSION}.tar.gz"
NGINX_URL="http://nginx.org/download/${NGINX_FILENAME}"
NGINX_PREFIX="/opt/nginx"
BUILD_DIR=`readlink -f "$(dirname $0)"`
TMP_DIR=`readlink -f "$(dirname $0)/../tmp"`
NGINX_TMPFILE="$TMP_DIR/$NGINX_FILENAME"

exists() {
  if command -v $1 &>/dev/null
  then
    return 0
  else
    return 1
  fi
}

if exists "md5sum"; then
  true
else
  echo "Cannot verify integrity with md5sum - exiting!"
  exit 5
fi

echo "Installing pre-requisites"
sudo apt-get install libpcre3-dev geoip-database libgeoip-dev ruby1.9.1 ruby1.9.1-dev libxml2-dev libxslt1-dev
sudo /usr/bin/gem1.9.1 install bundler --no-rdoc --no-ri

echo "Downloading $NGINX_URL"

if exists "wget"; then
  wget $NGINX_URL -O $NGINX_TMPFILE
elif exists "curl"; then
  curl $NGINX_URL -O $NGINX_TMPFILE
fi

nginx_md5=`md5sum $NGINX_TMPFILE | awk '{print $1}'`

if [ $NGINX_MD5SUM = $nginx_md5 ]; then
  echo "nginx checksum verified"
else
  echo "nginx checksum failed - expected $NGINX_MD5SUM received $(nginx_md5)"
fi

cd $TMP_DIR
tar zxvf $NGINX_TMPFILE
cd $TMP_DIR/nginx-$NGINX_VERSION
./configure --prefix=/opt/nginx \
  --with-http_ssl_module \
  --with-debug \
  --with-http_geoip_module
make
mkdir -p $TMP_DIR/$NGINX_PREFIX
env DESTDIR=$TMP_DIR make install
cd $TMP_DIR
bundle exec fpm -s dir -t deb \
  -n nginx -v $NGINX_VERSION --iteration 1 \
  -C $TMP_DIR \
  opt/nginx

