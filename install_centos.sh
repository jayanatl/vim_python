#!/bin/bash

# Sanity check
[ -f /etc/centos-release ] || { error "This script of for CentOS 7+"; exit 127; }

rm -rf /tmp/repo &>/dev/null
mkdir -p /tmp/repo
cd /tmp/repo
curl -L https://github.com/jayanatl/dotfiles/archive/initial_prototype.zip > repo.zip
sudo yum -y install unzip
unzip repo.zip
rm repo.zip
mv dotfiles* ~/.dotfiles
cd ~/.dotfiles
rm -rf /tmp/repo
bash setup_centos.sh

# TODO:
# Make this script inteligent to pickup os version and run right version of setup script
# Auto install different nvim configurations for GUI / Terminal users, eg: airline on terminal interface will break if proper fonts are not used

