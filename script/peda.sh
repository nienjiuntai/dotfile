#!/bin/bash

# pedagdb
git clone https://github.com/longld/peda.git $HOME/.config/peda
echo "source $HOME/.config/peda/peda.py" >> ~/.gdbinit
