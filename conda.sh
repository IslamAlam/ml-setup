#!/bin/bash
# Go to home directory

if [ -w "/opt/" ]; then ROOT_DIR=/opt; echo "WRITABLE"; else ROOT_DIR=$HOME/.local/opt; echo "NOT WRITABLE"; fi
bundleDir=$PWD
export ROOT_DIR
mkdir -p $ROOT_DIR/conda

cd $ROOT_DIR/

# Install conda as jovyan and check the md5 sum provided on the download site
CONDA_DIR=$ROOT_DIR/conda
NB_USER=$USER
PYTHON_VERSION=default
echo $NB_USER
MINICONDA_VERSION=4.8.3
MINICONDA_MD5=d63adf39f2c220950a063e0529d4ff74
CONDA_VERSION=4.8.3

wget --quiet https://repo.continuum.io/miniconda/Miniconda3-py38_${MINICONDA_VERSION}-Linux-x86_64.sh
echo "${MINICONDA_MD5} *Miniconda3-py38_${MINICONDA_VERSION}-Linux-x86_64.sh" | md5sum -c -
/bin/bash Miniconda3-py38_${MINICONDA_VERSION}-Linux-x86_64.sh -f -b -p $CONDA_DIR
rm Miniconda3-py38_${MINICONDA_VERSION}-Linux-x86_64.sh
cd $ROOT_DIR/conda/bin
source activate
echo "conda ${CONDA_VERSION}" >> $CONDA_DIR/conda-meta/pinned
conda config --system --prepend channels conda-forge
conda config --system --set auto_update_conda false
conda config --system --set show_channel_urls true
conda config --system --set channel_priority strict
if [ ! $PYTHON_VERSION = 'default' ]; then conda install --yes python=$PYTHON_VERSION; fi
conda list python | grep '^python ' | tr -s ' ' | cut -d '.' -f 1,2 | sed 's/$/.*/' >> $CONDA_DIR/conda-meta/pinned
conda install --quiet --yes conda
conda install --quiet --yes pip
conda update --all --quiet --yes
conda clean --all -f -y
rm -rf /home/$NB_USER/.cache/yarn
fix-permissions $CONDA_DIR
fix-permissions /home/$NB_USER

# https://stackoverflow.com/questions/22510705/get-the-latest-download-link-programmatically

# Determine latest version:
# latestVer=$(curl 'https://repo.anaconda.com/archive/' | 
#    grep -oP 'href="Anaconda3-\K[0-9]+\.[0-9]+' | 
#    sort -t. -rn -k1,1 -k2,2 | head -1)
# 
# # Echo latest version:
# echo "Anaconda3-${latestVer}-Linux-x86_64.sh" 
# # Download latest versanaconda-navigatorion:
# # curl "https://repo.anaconda.com/archive/Anaconda3-${latestVer}-Linux-x86_64.sh" > Anaconda3-latest-Linux-x86_64.sh
# 
# wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ./miniconda.sh
# bash ./miniconda.sh -b -u -p $ROOT_DIR/conda
# rm ./miniconda.sh

# https://docs.anaconda.com/anaconda/install/silent-mode/
#eval "$(~/.local/apps/miniconda/bin/conda shell.zsh hook)"

#bash Anaconda3-latest-Linux-x86_64.sh -b -p ~/anaconda
#rm Anaconda3-latest-Linux-x86_64.sh
#echo '. ~/anaconda/etc/profile.d/conda.sh' >> ~/.bashrc 

# Refresh basically
#source $HOME/.bashrc
cd $ROOT_DIR/conda/bin
source activate

conda config --set auto_activate_base false

conda init bash

#conda update conda
#conda install -c anaconda anaconda-navigator
cd $bundleDir 
source ./conda_all.sh
echo "Installation is complete :)"