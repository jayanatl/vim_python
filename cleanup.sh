#!/bin/bash
###############################################################################
# Script to cleanup development environment in my workstation                 #
###############################################################################

# TODO:
# Generate local log file

# Exit incase of any error
set -e

cd ${HOME}/.dotfiles
source bin/common.sh

user_checks

# Start execution
for step in $(list_install_steps r); do
    action "Uninstalling ${step}"
	${step}/uninstall.sh || true
done
