#!/bin/bash
###############################################################################
# Script to install and configure neovim
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
 brew install neovim 

 # Clone dotfiles repo
 # This must be done by setup file
 # Folder structure
 .dotfiles_backup/
    org
    <epoch>/file
 # Create a new branch

 # Create Backup folder

 # Create org backup if not present

 # Create backup with epoc

 # Configure softlinks to dotfiles
}

############################
# Uninstall                #
############################
[[ ${OP} == "uninstall" ]] && {
 brew remove neovim 

 # Remove dotfile links
 # Restore old files
}

