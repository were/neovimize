# Dependences

- Ubuntu: `cmake, build-essential, gettext`
- OS X: `cmake, gettext`

# How to use

````
bash ./00-download.sh # Download and install Neovim; skip if already installed
bash ./01-plug.sh     # Install plugins
nvim                  # Manually open nvim to install plugins
bash ./02-coc.sh      # Install coc extensions
````

# Troubleshooting

## Local Changes to Plugins

If `Lazy` complains about local changes to plugins, a very simple way of
solving this is to remove the plugin and reinstall it. This can be done by

````
rm -rf ~/.local/share/nvim/
````

## Font Issue
I had a super hard time to setup the Markdown renderer in Neovim.
It kept giving me little squares instead of rendering the correct sections.
It is because of your terminal font. Go [NerdFont](https://www.nerdfonts.com/#downloads)
to download and install a font that supports the icons. Then setup your terminal
font to this NerdFont.
