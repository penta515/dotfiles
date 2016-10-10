#!/bin/bash

DOT_FILES=(.zshrc .vimrc)

mkdir $HOME/.vim

for file in ${DOT_FILES[@]}
do
    ln -sf $HOME/github/dotfiles/$file $HOME/$file
done
