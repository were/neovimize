#!/bin/bash

# Download vim plug.
curl -s https://raw.githubusercontent.com/folke/lazy.nvim/main/bootstrap.lua

INIT_PREFIX=$HOME/.config/nvim

mkdir -p $INIT_PREFIX
mkdir -p $INIT_PREFIX/lua

cp ./init.lua $INIT_PREFIX
cp ./legacy.vim $INIT_PREFIX

mkdir -p $INIT_PREFIX/lua/config
cp bootstrap.lua $INIT_PREFIX/lua/config/lazy.lua

mkdir -p $INIT_PREFIX/lua/plugins
cp plugins.lua $INIT_PREFIX/lua/plugins/init.lua
