#!/bin/bash

if [ -z "$1" ]
then
    echo "Will ignore private information setup"
else
    # extract configs contain private information
    # eg: ssh key, ssh hosts, etc.
    tar xvf $1
fi

# install packages
sudo apt update
sudo apt-get install -y git wget curl vim openssh-server python3 python3-pip gcc g++ gdb make cmake wireguard

# vimrc 
if [ -d "config/vim" ]
then
    mkdir -p $HOME/.vim/colors
    cp config/vim/vimrc $HOME/.vimrc
    cp config/vim/monokai.vim $HOME/.vim/colors/monokai.vim
    git clone https://github.com/VundleVim/Vundle.vim.git $HOME/.vim/bundle/Vundle.vim
    vim +PluginInstall +qall
fi

# tmux
if [ -d "config/tmux" ]
then
    cp config/tmux/tmux.conf $HOME/.tmux.conf
fi

# wgconfig
if [ -d "config/wgconfig" ]
then
    sudo cp config/wgconfig/wg0.conf /etc/wireguard/wg0.conf
    sudo systemctl enable wg-quick@wg0
fi

#ssh
if [ -d "config/ssh" ]
then
    if [ -f "config/ssh/config"]
    then
        cp config/ssh/config $HOME/.ssh/config
    fi
    if [ -f "config/ssh/id_rsa"]
    then
        cp config/ssh/id_rsa $HOME/.ssh/id_rsa
    fi
    if [ -f "config/ssh/id_rsa.pub" ]
    then
        cp config/ssh/id_rsa.pub $HOME/.ssh/id_rsa.pub
    fi
fi

# install scripts
scripts=($(ls script))
for script in ${!scripts[@]};
do
    echo ${script}')' "${scripts[$script]%.sh}"
done

read -p '>(all if empty) ' inpt

if [ -z "${inpt}" ];
then
    inpt=${!scripts[@]}
fi
for i in $inpt; do
    echo sh script/${scripts[$i]}
    sh script/${scripts[$i]}
done

# disable __pycache__
echo 'export PYTHONDONTWRITEBYTECODE=1' >> ~/.bashrc

# set alias
echo "alias clc='history -c && clear'" >> ~/.bashrc

##
# gsetting
#

# disable animation
gsettings set org.gnome.desktop.interface enable-animations false
