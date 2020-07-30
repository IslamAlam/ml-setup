#!/bin/bash

ROOT_DIR=$HOME/.local
mkdir -p $ROOT_DIR/src
mkdir -p $ROOT_DIR/build/curl
mkdir -p $ROOT_DIR/devel/curl

cd $ROOT_DIR/src
OPENSSL_VERSION=1.1.1g
CURL_VERSION=7.71.1
wget -O curl-$CURL_VERSION.tar.gz https://curl.haxx.se/download/curl-$CURL_VERSION.tar.gz

tar -zxf curl-$CURL_VERSION.tar.gz


cd curl-$CURL_VERSION

# https://superuser.com/questions/1308079/building-git-on-an-ancient-linux-distribution
# LDFLAGS="-L/usr/src/openssl-1.1.1g -Wl,-rpath,/usr/src/openssl-1.1.1g" LIBS="-ldl" ./configure --with-ssl=/usr/src/openssl-1.1.1g --with-libssl-prefix=/usr/src/openssl-1.1.1g --disable-ldap --enable-libcurl-option
#./configure --prefix=$ROOT_DIR/build/curl \
#    --with-ssl=$ROOT_DIR/build/openssl 

LDFLAGS="-L/home/mans_is/.local/build/openssl/ -Wl,-rpath,/home/mans_is/.local/build/openssl/" LIBS="-ldl" \
     ./configure --prefix="$ROOT_DIR/build/curl" --with-ssl=/home/mans_is/.local/build/openssl/ --with-libssl-prefix=/home/mans_is/.local/build/openssl/ --disable-ldap --enable-libcurl-option


# /home/mans_is/.local/build/openssl/share/doc/openssl/html/man7/x509.html

# ./configure --prefix="$HOME/.local" \
#     --with-ssl

make
make install