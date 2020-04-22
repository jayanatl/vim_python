#!/bin/bash
###############################################################################
# Script to setup development environment in my workstation                   #
###############################################################################

# Permission check
(( $UID !=0 )) || {echo "Do not run this as 'root'"; exit 127;}
sudo -l mkdir || {echo "Sudo privillege needed to continue setup"; exit 127;}

function this_os() {
  # return os name
  OS=$(uname)
  if [[ ${OS} == "Linux" ]]; then
    OS=$(grep -w ID /etc/*-release 2>/dev/null|cut -d\" -f2)
  fi
  echo -e ${OS}
}

# Install basic tools needed to kickoff configuration
OS=this_os
case ${OS} in
  Darwin | darwin)
    echo "Mac OS detected, seting up brew, zip and git"
    echo "TODO:"
    ;;

  centos | redhat)
    sudo yum install curl unzip
    ;;
  
  fedora)
    sudo dnf update -y
    sudo dnf install curl unzip
    ;;
  
  *)
    echo "Sorry, OS: ${OS}, currently not supported by this script"
    exit 127
    ;;
esac


# Clone repo locally

# Start execution
