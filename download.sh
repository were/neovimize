RESTORE_PWD=`pwd`

# Init $HOME/.local/repo
mkdir -p $HOME/.local
cd $HOME/.local
mkdir -p repo
cd repo

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
  git pull origin stable
else
  echo "Downloading neovim from GitHub..."
  git clone https://github.com/neovim/neovim
  cd neovim
fi

echo "Check out the stable version..."
LATEST_VERSION="v"`git checkout stable | awk '{ print $NF }'`

if [ $LATEST_VERSION \> $NVIM_VERSION ]; then
  # Build and install
  make CMAKE_BUILD_TYPE=Release CMAKE_INSTALL_PREFIX="$HOME/.local" > compile.log 2>&1
  if [ $? -eq "0" ]; then
    make install
    echo "Latest stable is newer than the current version!"
    echo "Built from source and installed to "$HOME/.local
    echo "It is highly recommended to append this after your shell-rc:"
    echo "export PATH=\"\$HOME/.local/bin\":\$PATH"
    rm compile.log
  else
    echo "Compilation failed! Please check ./compile.log for more details!"
  fi
else
  echo "neovim already up-to-date!"
fi

cd $RESTORE_PWD

