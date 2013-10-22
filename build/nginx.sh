#!/bin/bash -e
#
# Build Nginx from source, and wrap it up with fpm
#
# Authors:
#   Adam Jacobs <adam@opscode.com>
#   Sam Kottler <shk@linux.com>
#
# This script works on Ubuntu, and maybe on Debian.

# Tweak the version and the md5sum for new releases of nginx
NGINX_VERSION="1.5.1"
NGINX_SHA512SUM="0932179b55aff87f173a55e9fa3376a5186bf266b51e47517bef610ce2bc5d52f6bf2c8f5fe6361748442372b5dec9c93a8185bf4f102a177342e2ec2c059220"

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

if [ ! -e Gemfile ]; then
  echo "This script must be run from the top level of the rubygems/rubygems-aws repo"
  exit 5
fi

if exists "sha512sum"; then
  true
else
  echo "Cannot verify integrity with sha512sum - exiting!"
  exit 5
fi

echo "Installing pre-requisites"
sudo apt-get install -y libpcre3-dev geoip-database libgeoip-dev ruby1.9.1 ruby1.9.1-dev libxml2-dev libxslt1-dev libssl-dev libxslt-dev libxml2-dev make
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
make -j10
mkdir -p $TMP_DIR/$NGINX_PREFIX
env DESTDIR=$TMP_DIR make install
cd $TMP_DIR
bundle install
bundle exec fpm -s dir -t deb \
  -n nginx -v $NGINX_VERSION --iteration 1 \
  -C $TMP_DIR \
  opt/nginx

