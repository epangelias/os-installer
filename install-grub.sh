#!/bin/bash

git clone https://github.com/sandesh236/sleek--themes.git

# Navigate to the directory
cd 'sleek--themes/Sleek theme-dark'

if [ -f install.sh ]; then
  sudo bash install.sh
else
  echo "No installation script found. Please follow manual installation steps."
fi

cd ../..
rm -rf sleek--themes