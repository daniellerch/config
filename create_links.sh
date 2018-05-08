#!/bin/bash
mkdir -p ~/.vim/plugin
ln -s `pwd`/vim/config.vim ~/.vim/plugin/config.vim
ln -s `pwd`/tmux/tmux.conf ~/.tmux.conf

