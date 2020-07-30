#!/bin/bash

ROOT_DIR=$HOME/.local
mkdir -p $ROOT_DIR/src
mkdir -p $ROOT_DIR/build/git
mkdir -p $ROOT_DIR/devel/git

cd $ROOT_DIR/src
OPENSSL_VERSION=1.1.1g
CURL_VERSION=7.71.1

GIT_VERSION=2.27.0

wget -O git-$GIT_VERSION.tar.gz https://github.com/git/git/archive/v$GIT_VERSION.tar.gz


tar -zxf git-$GIT_VERSION.tar.gz

cd git-$GIT_VERSION
make configure


LDFLAGS="-L/home/mans_is/.local/build/openssl/ -L/home/mans_is/.local/build/curl -Wl,-rpath,/home/mans_is/.local/build/openssl/,-rpath,/home/mans_is/.local/build/curl/lib/" LIBS="-ldl" ./configure --prefix="$ROOT_DIR/build/git" --with-curl=/home/mans_is/.local/build/curl --with-openssl=/home/mans_is/.local/build/openssl/

make
make install

echo 'export PATH=$ROOT_DIR/build/openssl:$PATH' >> $HOME/.bashrc
echo 'export PATH=$ROOT_DIR/build/curl:$PATH' >> $HOME/.bashrc
echo 'export PATH=$ROOT_DIR/build/git:$PATH' >> $HOME/.bashrc
