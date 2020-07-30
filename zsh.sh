#!/bin/bash
cd /tmp
wget ftp://ftp.gnu.org/gnu/ncurses/ncurses-6.1.tar.gz
tar xf ncurses-6.1.tar.gz
cd ncurses-6.1
./configure --prefix=$HOME/.local CXXFLAGS="-fPIC" CFLAGS="-fPIC"
make -j && make install

cd ..
wget -O zsh.tar.xz https://sourceforge.net/projects/zsh/files/latest/download
tar xf zsh.tar.xz
cd zsh*
./configure --prefix="$HOME/.local" \
    CPPFLAGS="-I$HOME/.local/include" \
    LDFLAGS="-L$HOME/.local/lib"
make -j && make install

# Set zsh to default
echo 'export SHELL=`which zsh`' >> $HOME/.bashrc
echo '[ -f "$SHELL" ] && exec "$SHELL" -l' >> $HOME/.bashrc

# https://thecodersblog.com/installing-zsh-oh-my-zsh-on-linux/
# Install oh-my-zsh
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# https://github.com/romkatv/powerlevel10k.git

git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

# Set ZSH_THEME="powerlevel10k/powerlevel10k" in ~/.zshrc.

mkdir -p ~/.oh-my-zsh/custom/plugins
git clone http://github.com/zsh-users/zsh-syntax-highlighting.git
