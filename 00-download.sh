#!/bin/bash

RESTORE_PWD=`pwd`

# Find the neovim version
NVIM=`which nvim`
if [ $? -eq "0" ]; then
  NVIM_VERSION=`$NVIM --version | head -n1 | awk '{ print $NF }'`
  echo $NVIM_VERSION
else
  NVIM_VERSION="v0.0.0"
  echo "neovim not installed!"
fi

# Clone the source from github repo.
if [ -d "./neovim" ]; then
  cd neovim
  git fetch origin stable
else
  echo "Downloading neovim from GitHub..."
  git clone https://github.com/neovim/neovim
  cd neovim
fi

echo "Check out the stable version..."
git checkout stable

# Build and install
echo "Latest stable is newer than the current version!"
echo Ours: ${NVIM_VERSION} "("v.0.0.0 indicates uninstalled")"
echo "Building from source"
make CMAKE_BUILD_TYPE=Release CMAKE_INSTALL_PREFIX="$HOME/.local/nvim" 2>&1 | tee $RESTORE_PWD/compile.log
if [ $? -eq "0" ]; then
  make install
  echo "Build done.. Installed to "$HOME/.local
  echo "It is highly recommended to append this after your shell-rc:"
  echo "export PATH=\"\$HOME/.local/nvim/bin\":\$PATH"
  echo "alias vim=nvim"
  rm $RESTORE_PWD/compile.log
else
  echo "Compilation failed! Please check ./compile.log for more details!"
fi

cd $RESTORE_PWD

