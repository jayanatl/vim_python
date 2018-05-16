#!/bin/bash

source ./lib_sh/echos.sh
bot "Hi! I'm going to setup this machine. Here I go..."

bot "Configuring EPEL Repository"
sudo yum install epel-release -y

bot "Update packages"
sudo yum -y update

bot "Install python3 and other necessary tools"
sudo yum -y install vim python-36* virtualenvwrapper git wget curl tree tmux mlocate fzf

bot "Setting up neovim"
curl -o /etc/yum.repos.d/dperson-neovim-epel-7.repo https://copr.fedorainfracloud.org/coprs/dperson/neovim/repo/epel-7/dperson-neovim-epel-7.repo
sudo yum -y install neovim

bot "Configuring git"
grep 'user = GITHUBUSER' ./homedir/.gitconfig > /dev/null 2>&1
if [[ $? = 0 ]]; then
    read -r -p "What is your github.com username? " githubuser
    read -r -p "What is your first name? " firstname
    read -r -p "What is your last name? " lastname
    read -r -p "What is your email? " email
fi
fullname="$firstname $lastname"
bot "Great $fullname, "
sed -i "s/GITHUBFULLNAME/$firstname $lastname/" ./homedir/.gitconfig > /dev/null 2>&1
sed -i 's/GITHUBEMAIL/'$email'/' ./homedir/.gitconfig
sed -i 's/GITHUBUSER/'$githubuser'/' ./homedir/.gitconfig

bot "creating symlinks for project dotfiles..."
pushd homedir > /dev/null 2>&1
now=$(date +"%Y.%m.%d.%H.%M.%S")

for file in .*; do
  if [[ $file == "." || $file == ".." ]]; then
    continue
  fi
  # if the file exists:
  if [[ -e ~/$file ]]; then
      mkdir -p ~/.dotfiles_backup/$now
      mv ~/$file ~/.dotfiles_backup/$now/$file
      echo "backup saved as ~/.dotfiles_backup/$now/$file"
  fi
  # symlink might still exist
  unlink ~/$file > /dev/null 2>&1
  # create the link
  ln -s ~/.dotfiles/homedir/$file ~/$file
  echo -en '\tlinked'
done

popd > /dev/null 2>&1


# Configure BASH
mkdir -p ~/bin
    # add fzf related stuff
    # setup virtual env wrapper 
    # wget bashrc

# Setup python
  # Install python3
  # wget pythonrc

# Configure git
  # Wget gitconf
  # Update gitconf?

# Configure nvim
  # create settings folders
  # Configure python support
  # Configure clipboard
  # Wget nvim settings file


