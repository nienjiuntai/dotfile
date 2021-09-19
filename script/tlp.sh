#!/bin/bash

# PPA install
sudo add-apt-repository ppa:linrunner/tlp # tlp-ppa
sudo add-apt-repository ppa:linuxuprising/apps # tlpui-ppa

sudo apt update
sudo apt install tlp tlp-rdw smartmontools ethtool tlpui -y
