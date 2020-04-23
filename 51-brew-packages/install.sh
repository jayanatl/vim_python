#!/bin/bash
###############################################################################
# Script to install prereqs
###############################################################################

# load common functions
source bin/common.sh

# Sanity check
OP=${0/.sh}
[[ ${OP} =~ ^(install|uninstall)$ ]] || {error Unsupported Operation: ${OP}; exit 127;}

# Permission check
(( $UID !=0 )) || {echo "Do not run this as 'root'"; exit 127;}
sudo -l mkdir || {echo "Sudo privillege needed to continue setup"; exit 127;}

OS=this_os

############################
# Install                  #
############################
[[ ${OP} == "install" ]] && {

    case ${OS} in
      Darwin | darwin)
        echo "Mac OS detected"
        cat brew_list | xargs brew install
        cat brew_cask_list | xargs brew cask install
        ;;

      centos | redhat | fedora)
        echo "Linux detected"
        cat brew_list | xargs brew install
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
        cat brew_list | xargs brew remove
        cat brew_cask_list | xargs brew cask remove
        ;;

      centos | redhat | fedora)
        echo "Linux detected"
        cat brew_list | xargs brew remove
        ;;
      
      *)
        echo "Sorry, OS: ${OS}, currently not supported by this script"
        exit 127
        ;;
    esac

}
