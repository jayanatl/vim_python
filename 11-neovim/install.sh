#!/bin/bash
###############################################################################
# Script to install and configure neovim
###############################################################################

# load common functions
source bin/common.sh

# Sanity check
OP=$(check_operation)

# Permission check
is_no_root
is_sudo

OS=$(this_os)

############################
# Install                  #
############################
[[ ${OP} == "install" ]] && {
 brew install neovim 

 # Install venv and necessary packages on that
 # compgen/which to find latest python by brew
 # create venv for nvim
 # anything else?

}

############################
# Uninstall                #
############################
[[ ${OP} == "uninstall" ]] && {
 # Remove dotfile links
 # Restore old files

 brew remove neovim 

}

