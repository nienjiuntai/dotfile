#!/bin/bash

url='https://repo.anaconda.com/archive/Anaconda3-2021.05-Linux-x86_64.sh'
wget $url -O conda.sh

bash ./conda.sh -p $HOME/.config/conda3

rm conda.sh
source ~/.bashrc
conda config --set auto_activate_base
