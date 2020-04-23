#!/bin/bash
###############################################################################
# Script to setup development environment in my workstation                   #
###############################################################################

# TODO:
# Generate log in a local file

# Exit incase of any error
set -e

[[ ${PWD} == ${HOME} ]] || {
  echo "Changin directory to HOME(${HOME})"
  echo "Execute command 'popd' to return to previous directory if needed"
  pushd ${HOME} >/dev/null
}

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
    sudo yum install git zip tar -y
    ;;

  fedora)
    sudo dnf install git zip tar -y
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


echo Setting up repo url
gitRepo=${1:-"jayanatl/dotfiles"}
branch=${2:-"refactor_mac"}
if [[ ${gitRepo} =~ ^http.*.git$ ]]; then
  repoUrl=gitRepo
else
  repoUrl="https://github.com/${gitRepo}.git"
fi
echo "Repo URL          : ${repoUrl}"
echo "Repo Branch to use: ${branch}"


echo Creating dotfiles_archive folder
DOTBKP=".dotfiles_backup"
mkdir -p "${DOTBKP}/repo"


echo Arciving old copy of dotfiles if present
if [ -d .dotfiles ]; then
  epoch=$(date +%s)
  echo "Creating .dotfiles repo backup: ${DOTBKP}/repo/dotfiles.${epoch}.zip"
  zip -r "${DOTBKP}/repo/dotfiles.${epoch}.zip" .dotfiles || { error Zip file creation filed, exiting; exit 127; }
  rm -rvf .dotfiles
fi

echo Settting up new local repo from repository
git clone ${repoUrl}
mv dotfiles .dotfiles
cd .dotfiles
git checkout ${branch}

echo Creating new branch for new changes
new_br=${USER}_${HOSTNAME}
git checkout -b ${new_br}

# Start execution




# Return to the directory where execution started
popd
