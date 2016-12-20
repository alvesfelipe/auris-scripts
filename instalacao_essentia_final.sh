#!/bin/bash

#controle de diretório de download
this_dir=`pwd`
sudo sed -i '$ a\deb http://us.archive.ubuntu.com/ubuntu trusty main universe' /etc/apt/sources.list
sudo add-apt-repository -y ppa:mc3man/trusty-media
sudo apt update

#atualização do sistema
sudo apt upgrade -y

#instalação de dependências
sudo apt install -y gcc g++ make mplayer build-essential libyaml-dev libfftw3-dev libavresample-dev python-dev  libavresample1 libsamplerate0-dev libtag1-dev python-numpy-dev python-numpy python-yaml cmake ffmpeg gstreamer0.10-ffmpeg lame yasm swig libqt4-dev libyaml-dev swig python-dev pkg-config

#dependências que precisam ser removidas
sudo apt-get remove -y libavcodec-dev libavformat-dev libavutil-dev

#dependências extras que precisam ser compiladas

#download libav12
cd $this_dir
mkdir ./libav
cd ./libav
wget -c https://libav.org/releases/libav-12.tar.gz
tar -xzf libav-12.tar.gz
cd ./libav-12/
./configure --enable-shared
make
sudo make install
#libav12 instalado e pronto

#instalar fftw
cd $this_dir
mkdir ./fftw
cd ./fftw
wget -c http://www.fftw.org/fftw-3.3.5.tar.gz
tar -xzf ./fftw-3.3.5.tar.gz
cd fftw-3.3.5/
./configure
make
sudo make install
# fftw instalado

#instalar libsnd, dependência de libsamplerate
cd $this_dir
mkdir ./libsndfile
cd ./libsndfile
wget -c http://www.mega-nerd.com/libsndfile/files/libsndfile-1.0.27.tar.gz
tar -xzf ./libsndfile-1.0.27.tar.gz
cd ./libsndfile-1.0.27/
./configure
make
sudo make install

#instalar libsamplerate
cd $this_dir
mkdir ./libsamplerate
cd ./libsamplerate
wget -c http://www.mega-nerd.com/SRC/libsamplerate-0.1.9.tar.gz
tar -xzf ./libsamplerate-0.1.9.tar.gz
cd ./libsamplerate-0.1.9/
export PKG_CONFIG_PATH=/usr/local/lib/pkgconfig
./configure
make
sudo make install
sudo ldconfig -v
#sndfile-resample

#instalar taglib dependência de essentia
cd $this_dir
mkdir ./taglib
cd ./taglib
wget -c http://taglib.org/releases/taglib-1.11.1.tar.gz
tar -xzf ./taglib-1.11.1.tar.gz
cd ./taglib-1.11.1/
cmake -DCMAKE_INSTALL_PREFIX=/usr/local -DCMAKE_BUILD_TYPE=Release -DBUILD_EXAMPLES=ON
make
sudo make install

#instalar libyaml dependência de essentia
cd $this_dir
mkdir ./libyaml
cd ./libyaml
wget -c http://pyyaml.org/download/libyaml/yaml-0.1.7.tar.gz
tar -xzf ./yaml-0.1.7.tar.gz
cd ./yaml-0.1.7/
./configure
make
sudo make install

#instalar gaia
cd $this_dir
mkdir ./gaia
cd ./gaia
wget -c https://github.com/MTG/gaia/archive/master.zip
unzip -x ./master.zip
cd ./gaia-master/
./waf configure
./waf
sudo ./waf install
#fim gaia

#instalar essentia
cd $this_dir
mkdir ./essentia
cd ./essentia
wget -c https://github.com/MTG/essentia/archive/v2.1_beta3.zip
unzip -x ./v2.1_beta3.zip
cd ./essentia-2.1_beta3/
./waf configure --mode=release --with-gaia
./waf
sudo ./waf install
cd $this_dir

sudo cp -a /usr/local/lib/libessentia.so /usr/lib/

echo "OK, tudo pronto."
