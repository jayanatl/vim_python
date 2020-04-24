#!/bin/bash
###############################################################################
# Script to install Python
###############################################################################

# load common functions
source bin/common.sh

# Sanity check
OP=$(check_operation)

# Permission check
# TODO
# Change following function to check_no_root_execution and check sudo_access
check_perms

OS=$(this_os)

############################
# Install                  #
##############G##############
[[ ${OP} == "install" ]] && {
  # TODO: If brew exists, skip installation and do update/brew doctor
  # Install brew
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

  # Configure brew
  if [[ ${OS} =~ ^(centos|redhat|fedora)$ ]]; then
    # Cleanup entry if already there
    sed -i "/brew shellenv/d" ~/.profile ~/.bash_profile ~/.bashrc 2>/dev/null
    
    # Add new entries to above files
    cat <<\EOF | tee -a ~/.profile | tee -a ~/.bash_profile >> ~/.bashrc
    test -d ~/.linuxbrew && eval $(~/.linuxbrew/bin/brew shellenv)
    test -d /home/linuxbrew/.linuxbrew && eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)
    export PATH="/usr/local/sbin:$PATH" # brew shellenv related entry for mac
    EOF
  fi
}


############################
# Uninstall                #
############################
[[ ${OP} == "uninstall" ]] && {
  
  # Uninstall any packages installed
    case ${OS} in
      Darwin | darwin)
        echo "Mac OS detected, brew will not be removed"
        # brew remove python@3.8
        ;;

      centos | redhat | fedora)
        echo "Removing linuxbrew"
        sed -i "/brew shellenv/d" ~/.profile ~/.bash_profile ~/.bashrc 2>/dev/null
        test -d ~/.linuxbrew && sudo rm -rvf ~/.linuxbrew
        test -d /home/linuxbrew/.linuxbrew && sudo rm -rvf /home/linuxbrew
        ;;
      
      *)
        echo "Sorry, OS: ${OS}, currently not supported by this script"
        exit 127
        ;;
    esac
}
