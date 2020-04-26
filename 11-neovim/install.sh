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


elif [[ ${OP} == "uninstall" ]]; then
############################
# Uninstall                #
############################
 # Remove dotfile links
 # Restore old files

 brew remove neovim 

fi
