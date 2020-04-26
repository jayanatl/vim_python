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
	# Configure git global
	bot "Configuring git..."
	read -r -p "Your github userid: " githubuser
	read -r -p "Your Full name: " fullname
	read -r -p "Your Email: " email 
	
	sed -i "s/name = .*/name = ${fullname}/" "${HOME}/.gitconfig"
	sed -i "s/email = .*/email = ${email}/" "${HOME}/.gitconfig"
	sed -i "s/user = .*/name = ${githubuser}/" "${HOME}/.gitconfig"

elif [[ ${OP} == "uninstall" ]]; then
############################
# Uninstall                #
############################
	echo "Nothing to do here"

fi
