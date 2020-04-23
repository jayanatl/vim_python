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

# Permission checks
(( $UID !=0 )) || { echo "Do not run this as 'root'"; exit 127; }
sudo -l mkdir 2>/dev/null|| { error "Sudo privillege needed to continue setup"; exit 127; }

read -r -p "Do you want to reboot after completion: (n)? " REBOOT
[[ $REBOOT =~ ^(y|Y)$ ]] && REBOOT=y || REBOOT=n

case ${OS} in
  Darwin | darwin)
    echo "Mac OS detected, Enterprise OS Team manages packages"
    xcode-select --install
    ;;

  centos | redhat | fedora)
    sudo yum install git tar -y
    ;;

  fedora)
    sudo dnf install git tar -y
    ;;
  
  *)
    echo "Sorry, OS: ${OS}, currently not supported by this script"
    exit 127
    ;;
esac

# # Install brew
# /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
# 
# # Configure brew
# if [[ ${OS} =~ ^(centos|redhat|fedora)$ ]]; then
#   # Cleanup entry if already there
#   sed -i "/brew shellenv/d" ~/.profile 2>/dev/null
#   sed -i "/brew shellenv/d" ~/.bash_profile 2>/dev/null
#   
#   # Add new entries
#   test -d ~/.linuxbrew && eval $(~/.linuxbrew/bin/brew shellenv)
#   test -d /home/linuxbrew/.linuxbrew && eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)
#   test -r ~/.bash_profile && echo "eval \$($(brew --prefix)/bin/brew shellenv)" >>~/.bash_profile
#   echo "eval \$($(brew --prefix)/bin/brew shellenv)" >>~/.profile
# fi


# Setup repo url
gitRepo=${1:-"jayanatl/dotfiles"}
branch=${2:-"refactor_mac"}

if [[ ${gitRepo} =~ ^http.*.git$ ]]; then
  repoUrl=gitRepo
else
  repoUrl="https://github.com/${gitRepo}.git"
fi


# Create dotfiles_archive folder
mkdir -p ~/.dotfiles_backup/repo


# Move old copy of dotfiles to archive if present
if [ -d ~/.dotfiles ]; then
  zip -r ~/.dotfiles_backup/repo/dotfiles.bak.$(date +%s) ~/.dotfiles
fi

# Setup local repo/copy
git clone ${repoUrl}
mv dotfiles .dotfiles

# Checkout right branch
cd .dotfiles
git checkout ${branch}

# Create new branch for new changes
br_name=${USER}_${hostname}
git checkout -b ${br_name}

# Start execution
