#!/bin/bash
###############################################################################
# Script to create dotfiles backup
###############################################################################

# Exit incase of any error
set -e

# load common functions
source bin/common.sh

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
  echo "Baking up dot files that are being replaced"
  # Cleanup brew entry in dot.profile/dot.bashrc
  # Get that entry from current .bashrc/.profile before moving it to backup

  # Create org if not present
  # Create backup if files which are not simlinks to .dotfiles and is getting replaced
  #   and move those to backup folder


elif [[ ${OP} == "uninstall" ]]; then
############################
# Uninstall                #
############################
  echo "Restoring old dotfiles from backup"
  # Resetore files in reverse order

fi

