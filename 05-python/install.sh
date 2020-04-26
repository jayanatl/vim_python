#!/bin/bash
###############################################################################
# Script to install Python
###############################################################################

# load common functions
source bin/common.sh

# Sanity check
OP=$(check_operation)

# Permission check
is_no_root
is_sudo

OS=$(this_os)

############################
# Install                  #
##############G##############
[[ ${OP} == "install" ]] && {

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
}


############################
# Uninstall                #
############################
[[ ${OP} == "uninstall" ]] && {
  
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
}
