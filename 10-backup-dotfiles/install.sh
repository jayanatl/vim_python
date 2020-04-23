#!/bin/bash
###############################################################################
# Script to create dotfiles backup
###############################################################################

# load common functions
source bin/common.sh

# Sanity check
OP=$(check_operation)

# Permission check
check_perms

OS=$(this_os)

############################
# Install                  #
############################
[[ ${OP} == "install" ]] && {
  echo "Baking up dot files that are being replaced"
  # Create org if not present
  # Create backup if files which are not simlinks to .dotfiles and is getting replaced
  #   and move those to backup folder
}

############################
# Uninstall                #
############################
[[ ${OP} == "uninstall" ]] && {
  echo "Restoring old dotfiles from backup"
  # Resetore files in reverse order
}

