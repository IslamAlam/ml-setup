#!/bin/sh
# Go to home directory
ROOT_DIR=$HOME/.local

ROOT_DIR=$HOME/.local
mkdir -p $ROOT_DIR/apps/miniconda

cd $ROOT_DIR/apps/

# https://stackoverflow.com/questions/22510705/get-the-latest-download-link-programmatically

# Determine latest version:
latestVer=$(curl 'https://repo.anaconda.com/archive/' | 
   grep -oP 'href="Anaconda3-\K[0-9]+\.[0-9]+' | 
   sort -t. -rn -k1,1 -k2,2 | head -1)

# Echo latest version:
echo "Anaconda3-${latestVer}-Linux-x86_64.sh" 
# Download latest versanaconda-navigatorion:
# curl "https://repo.anaconda.com/archive/Anaconda3-${latestVer}-Linux-x86_64.sh" > Anaconda3-latest-Linux-x86_64.sh

wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ./miniconda.sh
bash ./miniconda.sh -b -u -p $ROOT_DIR/apps/miniconda
rm ./miniconda.sh

# https://docs.anaconda.com/anaconda/install/silent-mode/
eval "$(~/.local/apps/miniconda/bin/conda shell.zsh hook)"

#bash Anaconda3-latest-Linux-x86_64.sh -b -p ~/anaconda
#rm Anaconda3-latest-Linux-x86_64.sh
#echo '. ~/anaconda/etc/profile.d/conda.sh' >> ~/.bashrc 

# Refresh basically
#source $HOME/.bashrc

#conda update conda
#conda install -c anaconda anaconda-navigator 

echo "Installation is complete :)"