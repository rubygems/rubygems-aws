#!/bin/bash -e
#
# Build Nginx from source, and wrap it up with fpm
#
# Author: <adam@opscode.com>
#
# This script works on Ubuntu, and maybe on Debian.

# Tweak the version and the md5sum for new releases of nginx
NGINX_VERSION="1.2.6"
NGINX_SHA512SUM="659f01b0349292f7176f9bf6981bb0b270d724c5bd621556a0f1521d220995393789f6aea42ad3d1044207b9b2fb0aa40f81a069dbcb8eec4b3503b1e0826d64"

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

if exists "sha512sum"; then
  true
else
  echo "Cannot verify integrity with sha512sum - exiting!"
  exit 5
fi

echo "Installing pre-requisites"
sudo apt-get install -y libpcre3-dev geoip-database libgeoip-dev ruby1.9.1 ruby1.9.1-dev libxml2-dev libxslt1-dev libssl-dev libxslt-dev libxml2-dev
sudo /usr/bin/gem1.9.1 install bundler --no-rdoc --no-ri

echo "Downloading $NGINX_URL"

mkdir -p $TMP_DIR
if exists "wget"; then
  wget $NGINX_URL -O $NGINX_TMPFILE
elif exists "curl"; then
  curl $NGINX_URL -O $NGINX_TMPFILE
fi

nginx_sha512sum=`sha512sum $NGINX_TMPFILE | awk '{print $1}'`

if [ $NGINX_SHA512SUM = $nginx_sha512sum ]; then
  echo "nginx checksum verified"
else
  echo "nginx checksum failed - expected $NGINX_SHA512SUM received $(nginx_sha512sum)"
fi

cd $TMP_DIR
tar zxvf $NGINX_TMPFILE
cd $TMP_DIR/nginx-$NGINX_VERSION
./configure --prefix=/opt/nginx \
  --with-http_ssl_module \
  --with-debug \
  --with-http_geoip_module \
  --with-http_stub_status_module \
  --with-http_gzip_static_module \
  --with-http_realip_module \
  --with-http_stub_status_module
make
mkdir -p $TMP_DIR/$NGINX_PREFIX
env DESTDIR=$TMP_DIR make install
cd $TMP_DIR
bundle install
bundle exec fpm -s dir -t deb \
  -n nginx -v $NGINX_VERSION --iteration 2 \
  -C $TMP_DIR \
  opt/nginx

