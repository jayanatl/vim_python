#!/bin/bash

echo "Configuring EPEL Repository"
yum install epel-release -y

echo "Update packages"
yum -y update

echo "Install python3 and other necessary tools"
yum -y install vim python-36* virtualenvwrapper git wget curl tree tmux mlocate fzf

echo "Setting up neovim in CentOS 7+"
curl -o /etc/yum.repos.d/dperson-neovim-epel-7.repo https://copr.fedorainfracloud.org/coprs/dperson/neovim/repo/epel-7/dperson-neovim-epel-7.repo
yum -y install neovim

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


