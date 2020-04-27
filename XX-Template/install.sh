#!/bin/bash
###############################################################################
# Script to install/uninstall a tool
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
	# Stuff that need to be done to install a specific tool goes here
	# Along with its basic configuration
	# User specific customization can be done as part of post install script

elif [[ ${OP} == "uninstall" ]]; then
############################
# Uninstall                #
############################
	# Remove basic configuration
	# Stuff that need to be done to uninstall same tool goes here
	# User specific customization can be done as part of post install script

fi
