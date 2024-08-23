#!/bin/bash 

git clone https://github.com/epangelias/os-installer.git
cd os-installer
./install.sh
cd ..
rm -rf os-installer