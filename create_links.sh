#!/bin/bash
mkdir -p ~/.vim/plugin
ln -sf `pwd`/vim/config.vim ~/.vim/plugin/config.vim
ln -sf `pwd`/tmux/tmux.conf ~/.tmux.conf
ln -sf `pwd`/readline/inputrc ~/.inputrc
bash

