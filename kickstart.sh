#!/bin/bash
###############################################################################
# Script to setup development environment in my workstation                   #
###############################################################################

echo "Argument 1: ${1}"
echo "Argument 2: ${2}"


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
    sudo yum install unzip -y
    ;;
  
  fedora)
    sudo dnf install unzip -y
    ;;
  
  *)
    echo "Sorry, OS: ${OS}, currently not supported by this script"
    exit 127
    ;;
esac


# Copy repo locally and switch to right branch
read -r -p "Repo: (jayanatl/dotfiles)? " repo
read -r -p "Branch: (refactor_mac)? " branch
read -r -p "Reboot after completion: (n)? " REBOOT

gitrepo=${gitrepo:-"jayanatl/dotfiles"}
branch=${branch:-"refactor_mac"}
[[ $REBOOT =~ ^(y|Y)$ ]] && REBOOT=y || REBOOT=n

# if repo =~ ^http.*.git$; then repourl=${repo} # TODO
repoUrl="https://github.com/${gitrepo}.git"

# Remove dotfiles folder if it already exists

# Unzip and move to right place

# Start execution
