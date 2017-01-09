#!/bin/bash

dir=`pwd`
#instalar o puredata vanilla
sudo apt-get install -y libasound2-dev libjack-dev libtool automake g++
mkdir pd-vanilla
cd pd-vanilla
wget -c http://msp.ucsd.edu/Software/pd-0.47-1.src.tar.gz
tar -xzf *.gz
cd ./pd-0.47-1/
./autogen.sh;
./configure;
make;
sudo make install
#fim da instalação do pd-vanilla

#ATENÇÃO: libs é uma pasta dentro do diretório Auris_PD

cd $dir
cd ..
cd auris-core/auris-filter/Auris_PD
cc -DPD -fPIC -Wall -o libs/pvu~.o -c libs/pvu~.c
ld -shared -lc -lm -o libs/pvu~.pd_linux libs/pvu~.o
cc -DPD -fPIC -Wall -o libs/spigot~.o -c libs/spigot~.c
ld -shared -lc -lm -o libs/spigot~.pd_linux libs/spigot~.o
rm libs/*.o
sudo cp -a libs/*.pd_linux /usr/local/lib/pd/extra/
cd $dir
