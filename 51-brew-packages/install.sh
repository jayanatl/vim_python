#!/bin/bash
###############################################################################
# Script to install other favorite brew packages
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
scriptDir=$(dirname $0)

if [[ ${OP} == "install" ]]; then
############################
# Install                  #
############################

    case ${OS} in
      Darwin | darwin)
        echo "Mac OS detected"
        grep -v '#' ${scriptDir}/brew_list | xargs brew install
        grep -v '#' ${scriptDir}/brew_cask_list | xargs brew cask install
        ;;

      centos | redhat | fedora)
        echo "Linux detected"
        grep -v '#' ${scriptDir}/brew_list | xargs brew install
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

    case ${OS} in
      Darwin | darwin)
        echo "Mac OS detected"
        grep -v '#' ${scriptDir}/brew_list | xargs brew remove
        grep -v '#' ${scriptDir}/brew_cask_list | xargs brew cask remove
        ;;

      centos | redhat | fedora)
        echo "Linux detected"
        grep -v '#' ${scriptDir}/brew_list | xargs brew remove
        ;;
      
      *)
        echo "Sorry, OS: ${OS}, currently not supported by this script"
        exit 127
        ;;
    esac

fi
