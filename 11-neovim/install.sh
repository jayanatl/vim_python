#!/bin/bash
###############################################################################
# Script to install and configure neovim
###############################################################################
# Exit incase of any error
set -e

# load common functions
source bin/common.sh
source ~/.profile

# Sanity check
OP=$(check_operation)

# Permission check
is_no_root
is_sudo

OS=$(this_os)

if [[ ${OP} == "install" ]]; then
############################
# Install                  #
############################
 brew install neovim 

 # Install venv and necessary packages on that
 # compgen/which to find latest python by brew
 # create venv for nvim
 # anything else?

 # Setup virtual env for neovim
 PYTHON=$(compgen -c python|sort -u|tail -1)
 nvim_venv="${HOME}/.venv/nvim"
 ${PYTHON} -m venv ${nvim_venv}
 PYTHON="${nvim_venv}/bin/python"
 PIP="${nvim_venv}/bin/pip"
 ${PIP} install --upgrade pip
 ${PIP} install neovim \
	 flake8 \
	 isort \
	 black \
	 jedi

 # Put python info into init.vim
 sed -i "/let g:python3/s|=.*|= expand('${PYTHON}')|" ~/.config/nvim/init.vim
 # Install plugs
 nvim -E +PlugInstall +qall || true


elif [[ ${OP} == "uninstall" ]]; then
############################
# Uninstall                #
############################
 # Remove dotfile links
 # Restore old files

 brew remove neovim

fi
