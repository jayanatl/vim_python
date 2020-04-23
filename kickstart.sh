#!/bin/bash
###############################################################################
# Script to setup development environment in my workstation                   #
###############################################################################

# Exit incase of any error
set -e

# Function to grab OS name
function this_os() {
  # return os name
  OS=$(uname)
  if [[ ${OS} == "Linux" ]]; then
    OS=$(grep -w ID /etc/*-release 2>/dev/null|cut -d\" -f2)
  fi
  echo -e ${OS}
}
OS=$(this_os)

# Permission check
(( $UID !=0 )) || { echo "Do not run this as 'root'"; exit 127; }

# Check SUDO Privilleges for Linux systems

if [[ ${OS} =~ ^(darwin|Darwin)$ ]]; then
  sudo -l mkdir || { echo "Sudo privillege needed to continue setup"; exit 127; }
fi

read -r -p "Reboot after completion: (n)? " REBOOT
[[ $REBOOT =~ ^(y|Y)$ ]] && REBOOT=y || REBOOT=n

# Install basic tools needed to kickoff configuration
case ${OS} in
  Darwin | darwin)
    echo "Mac OS detected, seting up brew and git"
    echo "TODO:"
    ;;

  centos | redhat)
    sudo yum install git -y
    ;;
  
  fedora)
    sudo dnf install git -y
    ;;
  
  *)
    echo "Sorry, OS: ${OS}, currently not supported by this script"
    exit 127
    ;;
esac


# Setup repo url
gitRepo=${1:-"jayanatl/dotfiles"}
branch=${2:-"refactor_mac"}

if [[ ${gitRepo} =~ ^http.*.git$ ]]; then
  repoUrl=gitRepo
else
  repoUrl="https://github.com/${gitRepo}.git"
fi

# Remove dotfiles folder if it already exists


# Clone repo
cd ~
git clone ${repoUrl}

# Start execution
