#!/bin/bash

#dependências obrigatórias
sudo apt-get install -y build-essential libyaml-dev libfftw3-dev libavcodec-dev libavformat-dev libavutil-dev libavresample-dev python-dev libsamplerate0-dev libtag1-dev python-numpy-dev python-numpy python-yaml build-essential libqt4-dev libyaml-dev swig python-dev pkg-config yasm

dir=`pwd`

#opcionais importantes
mkdir ./fftw
cd ./fftw
wget -c http://www.fftw.org/fftw-3.3.5.tar.gz
tar -xzf *.gz
cd ./fftw-3.3.5/
./configure
make
sudo make install
cd $dir

mkdir ./ffmpeg
cd ./ffmpeg
wget -c https://launchpad.net/ubuntu/+archive/primary/+files/ffmpeg_2.8.10.orig.tar.xz
tar -xJf *.xz
cd ./ffmpeg-2.8.10
./configure
make
sudo make install

cd $dir

mkdir ./libsnd
cd ./libsnd
wget -c http://www.mega-nerd.com/libsndfile/files/libsndfile-1.0.27.tar.gz
tar -xzf *.gz
cd ./libsndfile-1.0.27
./configure
make
sudo make install
ldconfig -v

cd $dir
export PKG_CONFIG_PATH=/usr/local/lib/pkgconfig
mkdir ./libsamplerate
cd ./libsamplerate
wget -c http://www.mega-nerd.com/SRC/libsamplerate-0.1.9.tar.gz
tar -xzf *.gz
cd libsamplerate-0.1.9
./configure
make
sudo make install

cd $dir
mkdir ./taglib
cd ./taglib
wget -c http://taglib.org/releases/taglib-1.11.1.tar.gz
tar -xzf *.gz
cd ./taglib-1.11.1
cmake -DCMAKE_INSTALL_PREFIX=/usr/local -DCMAKE_BUILD_TYPE=Release .
make
sudo make install

cd $dir
mkdir ./yaml
cd ./yaml
wget -c http://pyyaml.org/download/libyaml/yaml-0.1.7.tar.gz
tar -xzf *.gz
cd ./yaml-0.1.7/
./configure
make
sudo make install

cd $dir
mkdir ./gaia
cd ./gaia
wget -c https://github.com/MTG/gaia/archive/master.zip
unzip -x *
cd ./gaia-master
./waf configure
./waf
sudo ./waf install

cd $dir
mkdir ./essentia
cd ./essentia
wget -c https://github.com/MTG/essentia/archive/v2.1_beta3.zip
unzip -x *
cd ./essentia-2.1_beta3
./waf configure --mode=release --with-gaia
./waf
sudo ./waf install

sudo cp -a /usr/local/lib/libessentia.so /usr/lib/
