
cd /tmp
GIT_VERSION=2.27.0
wget https://github.com/git/git/archive/v$GIT_VERSION.tar.gz -O git.tar.gz
tar -zxf git.tar.gz
cd git-$GIT_VERSION/
make configure
mkdir -p $HOME/.local
./configure --prefix=$HOME/.local
make install

echo 'export PATH=$HOME/.local/bin:$PATH' >> $HOME/.bashrc

git --version
