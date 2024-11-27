# Dependences

- Ubuntu: `cmake, build-essential, gettext`
- OS X: `cmake, gettext`

# How to use

````
bash ./00-download.sh # Download and install Neovim; skip if already installed
bash ./01-plug.sh     # Install plugins
````

# Misc

I had a super hard time to setup the Markdown renderer in Neovim.
It kept giving me little squares instead of rendering the correct sections.
It is because of your terminal font. Go [NerdFont](https://www.nerdfonts.com/#downloads)
to download and install a font that supports the icons. Then setup your terminal
font to this NerdFont.
