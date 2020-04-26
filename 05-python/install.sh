#!/bin/bash
###############################################################################
# Script to install Python
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
##############G##############

    case ${OS} in
      Darwin | darwin)
        echo "Mac OS detected, Enterprise OS Team manages packages"
        # brew install python@3.8
        ;;

      centos | redhat )
        sudo yum install python36 -y
        ;;

      fedora)
        sudo dnf install python37 -y
        ;;
      
      *)
        echo "Sorry, OS: ${OS}, currently not supported by this script"
        exit 127
        ;;
    esac



elif [[ ${OP} == "uninstall" ]]; then
############################
# Uninstall                #
############################
  
  # Uninstall any packages installed
    case ${OS} in
      Darwin | darwin)
        echo "Mac OS detected, Enterprise OS Team manages packages"
        # brew remove python@3.8
        ;;

      centos | redhat | fedora)
        yum remove python36 -y
        ;;
      fedora)
        dnf remove python37 -y
        ;;
      
      *)
        echo "Sorry, OS: ${OS}, currently not supported by this script"
        exit 127
        ;;
    esac
fi
