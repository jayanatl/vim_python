#!/bin/bash
###############################################################################
# Script to install neovim
###############################################################################

# load common functions
source bin/common.sh

# Sanity check
OP=${0/.sh}
[[ ${OP} =~ ^(install|uninstall)$ ]] || {error Unsupported Operation: ${OP}; exit 127;}

############################
# Install                  #
############################
[[ ${OP} == "install" ]] && {
 mkdir ~/.dot_files_backup
}

############################
# Uninstall                #
############################
[[ ${OP} == "uninstall" ]] && {
 brew remove neovim 
}

