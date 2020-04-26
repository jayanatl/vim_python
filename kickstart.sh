#!/bin/bash
###############################################################################
# Script to setup development environment in my workstation                   #
###############################################################################

# TODO:
# Generate local log file

# Exit incase of any error
set -e

[[ ${PWD} != ${HOME} ]] && {
  POPD=1
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

# Root no execute check
(( $UID !=0 )) || { echo "Do not run this as 'root'"; exit 127; }
# Sudo access check
sudo -l mkdir >/dev/null|| { error "Sudo privillege needed to continue setup"; exit 127; }

read -r -p "Do you want to reboot after completion: (n)? " REBOOT
[[ $REBOOT =~ ^(y|Y)$ ]] && REBOOT=y || REBOOT=n

case ${OS} in
  Darwin | darwin)
    echo "Mac OS detected, Enterprise OS Team manages packages"
    xcode-select --install
    ;;

  centos | redhat | fedora)
    sudo yum install git zip tar gcc -y
    ;;

  fedora)
    sudo dnf install git zip tar gcc -y
    ;;
  
  *)
    echo "Sorry, OS: ${OS}, currently not supported by this script"
    exit 127
    ;;
esac


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
while step in $(list_install_steps); do
    echo ${step}/install.sh
done

# Place for post install config?

# Return to the directory where execution started
((${POPD:-0})) && popd
