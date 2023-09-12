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
LATEST_VERSION="v"`git checkout stable 2>&1 | awk '{ print $NF }'`

if [ $LATEST_VERSION \> $NVIM_VERSION ]; then
  # Build and install
  echo "Latest stable is newer than the current version!"
  echo latest: ${LATEST_VERSION}
  echo ours: ${NVIM_VERSION} "("v.0.0.0 indicates uninstalled")"
  echo "Built from source and installed to "$HOME/.local
  make CMAKE_BUILD_TYPE=Release CMAKE_INSTALL_PREFIX="$HOME/.local" > $RESTORE_PWD/compile.log 2>&1
  if [ $? -eq "0" ]; then
    make install
    echo "It is highly recommended to append this after your shell-rc:"
    echo "export PATH=\"\$HOME/.local/bin\":\$PATH"
    echo "alias vim=nvim"
    rm compile.log
  else
    echo "Compilation failed! Please check ./compile.log for more details!"
  fi
else
  echo "neovim already up-to-date!"
fi

cd $RESTORE_PWD

