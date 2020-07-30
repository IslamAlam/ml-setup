ROOT_DIR=$HOME/.local
mkdir -p $ROOT_DIR/src
mkdir -p $ROOT_DIR/build/openssl
mkdir -p $ROOT_DIR/build/ssl
mkdir -p $ROOT_DIR/devel/openssl


cd $ROOT_DIR/src

OPENSSL_VERSION=1.1.1g

wget -O openssl-$OPENSSL_VERSION.tar.gz https://www.openssl.org/source/openssl-$OPENSSL_VERSION.tar.gz

tar -zxf openssl-$OPENSSL_VERSION.tar.gz

cd openssl-$OPENSSL_VERSION

./config --prefix=$ROOT_DIR/build/openssl --openssldir=$ROOT_DIR/build/ssl enable-egd

# ./config enable-shared enable-egd
make
make install

LDFLAGS="-L/usr/src/openssl-1.1.1g -Wl,-rpath,/usr/src/openssl-1.1.1g" LIBS="-ldl" ./configure --with-ssl=/usr/src/openssl-1.1.1g --with-libssl-prefix=/usr/src/openssl-1.1.1g --disable-ldap --enable-libcurl-option