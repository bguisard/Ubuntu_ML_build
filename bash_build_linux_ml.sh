#!/bin/bash
# Designed for Ubuntu 16.04 LTS and NVIDIA GTX1070


# Updates system and basic build tools

sudo apt-get update
sudo apt-get --assume-yes upgrade
sudo apt-get --assume-yes install software-properties-common
sudo apt-get --assume-yes install build-essential gcc g++make make binutils gfortran
sudo apt-get --assume-yes install git pkg-config python-dev
sudo apt-get --assume-yes install software-properties-common wget
sudo apt-get --assume-yes install autoremove
sudo rm -rf /var/lib/apt/lists/*


# Download and Install NVIDIA drivers
# May need to update download link
wget "http://developer.download.nvidia.com/compute/cuda/repos/ubuntu1604/x86_64/cuda-repo-ubuntu1604_8.0.44-1_amd64.deb" -O "cuda-repo-ubuntu1604_8.0.44-1_amd64.deb"

sudo dpkg -i cuda-repo-ubuntu1604_8.0.44-1_amd64.deb
sudo apt-get update
sudo apt-get -y install cuda
sudo modprobe nvidia
nvidia-smi

# Add Cuda libraries to .bashrc
echo 'export PATH=/usr/local/cuda/bin:$PATH' >> ~/.bashrc
echo 'export LD_LIBRARY_PATH=/usr/local/cuda/lib64:$LD_LIBRARY_PATH' >> ~/.bashrc
source ~/.bashrc

# Install cudnn libraries
# May need to update download link

wget "http://files.fast.ai/files/cudnn.tgz" -O "cudnn.tgz"
tar -zxf cudnn.tgz
cd cuda
sudo cp lib64/* /usr/local/cuda/lib64/
sudo cp include/* /usr/local/cuda/include/


# Install python without Anaconda
# For anaconda comment this block and uncomment the next one
sudo apt-get update && apt-get install -y python-numpy python-scipy python-nose \
 python-h5py python-skimage python-matplotlib python-pandas \
 python-sklearn python-sympy
sudo apt-get clean && sudo apt-get autoremove
sudo rm -rf /var/lib/apt/lists/*

sudo apt-get update
sudo apt-get install -y python-dev python3-dev python-numpy python3-numpy build-essential python-pip python3-pip python-virtualenv swig python-wheel libcurl3-dev
sudo apt-get install -y libfreetype6-dev libpng12-dev
pip3 install -U matplotlib ipython[all] jupyter pandas scikit-image

# Install Anaconda for current user
#mkdir downloads
#cd downloads
#wget "https://repo.continuum.io/archive/Anaconda2-4.2.0-Linux-x86_64.sh" -O "Anaconda2-4.2.0-Linux-x86_64.sh"
#bash "Anaconda2-4.2.0-Linux-x86_64.sh" -b

#echo "export PATH=\"$HOME/anaconda2/bin:\$PATH\"" >> ~/.bashrc
#export PATH="$HOME/anaconda2/bin:$PATH"
#conda install -y bcolz
#conda upgrade -y --all


# Download TMUX
wget "https://github.com/tmux/tmux/releases/download/2.5/tmux-2.5.tar.gz"
tar xzf tmux-2.5.tar.gz
rm -f tmux-2.5.tar.gz
cd tmux-2.5
./configure
sudo make install
cd -
sudo rm -rf /usr/local/src/tmux-*
sudo mv tmux-${VERSION} /usr/local/src
