#!/bin/bash
###############################################################################
# Script to install other favorite brew packages
###############################################################################

# load common functions
source bin/common.sh

# Sanity check
OP=$(check_operation)

# Permission check
check_perms

OS=$(this_os)
scriptDir=$(dirname $0)

############################
# Install                  #
############################
[[ ${OP} == "install" ]] && {

    case ${OS} in
      Darwin | darwin)
        echo "Mac OS detected"
        cat ${scriptDir}/brew_list | xargs brew install
        cat ${scriptDir}/brew_cask_list | xargs brew cask install
        ;;

      centos | redhat | fedora)
        echo "Linux detected"
        cat ${scriptDir}/brew_list | xargs brew install
        ;;
      
      *)
        echo "Sorry, OS: ${OS}, currently not supported by this script"
        exit 127
        ;;
    esac

}


############################
# Uninstall                #
############################
[[ ${OP} == "uninstall" ]] && {

    case ${OS} in
      Darwin | darwin)
        echo "Mac OS detected"
        cat ${scriptDir}/brew_list | xargs brew remove
        cat ${scriptDir}/brew_cask_list | xargs brew cask remove
        ;;

      centos | redhat | fedora)
        echo "Linux detected"
        cat ${scriptDir}/brew_list | xargs brew remove
        ;;
      
      *)
        echo "Sorry, OS: ${OS}, currently not supported by this script"
        exit 127
        ;;
    esac

}
