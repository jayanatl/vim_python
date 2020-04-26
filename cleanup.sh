#!/bin/bash
###############################################################################
# Script to setup development environment in my workstation                   #
###############################################################################

# TODO:
# Generate local log file

# Exit incase of any error
set -e

cd ${HOME}

OS=$(this_os)
user_checks

# Start execution
for step in $(list_install_steps r); do
    action "Uninstalling ${step}"
	${step}/uninstall.sh
done

