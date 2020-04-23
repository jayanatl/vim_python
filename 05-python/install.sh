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
        ;;

      centos | redhat)
        sudo yum update -y
        sudo yum install tar python36 gcc -y
        ;;
      
      fedora)
        sudo dnf update -y
        sudo dnf install tar python37 gcc -y
        ;;
      
      *)
        echo "Sorry, OS: ${OS}, currently not supported by this script"
        exit 127
        ;;
    esac

    # Install brew
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

    # Configure brew
    if [[ ${OS} =~ ^(centos|redhat|fedora)$ ]]; then
      test -d ~/.linuxbrew && eval $(~/.linuxbrew/bin/brew shellenv)
      test -d /home/linuxbrew/.linuxbrew && eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)
      test -r ~/.bash_profile && echo "eval \$($(brew --prefix)/bin/brew shellenv)" >>~/.bash_profile
      echo "eval \$($(brew --prefix)/bin/brew shellenv)" >>~/.profile
    fi
}


############################
# Uninstall                #
############################
[[ ${OP} == "uninstall" ]] && {
  sed -i "/brew/d" ~/.profile 2>/dev/null
  sed -i "/brew/d" ~/.bash_profile 2>/dev/null
  
  # Remove Brew folder
  test -d ~/.linuxbrew && rm -rf ~/.linuxbrew
  test -d /home/linuxbrew/.linuxbrew && rm -rf /home/linuxbrew/.linuxbrew
  # Don't remove brew on MAC

  # Uninstall any packages installed
  case ${OS} in
    Darwin | darwin)
      echo "Mac OS detected, not removing brew"
      ;;

    centos | redhat)
      sudo yum remove git tar python36 gcc -y || True
      ;;
    
    fedora)
      sudo dnf remove git tar python37 gcc -y || True
      ;;
    
    *)
      echo "Sorry, OS: ${OS}, currently not supported by this script"
      exit 127
      ;;
  esac
}
