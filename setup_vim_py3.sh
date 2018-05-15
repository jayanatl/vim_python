#!/bin/bash


echo "Configuring EPEL Repository"
yum install epel-release -y

# Install vim, python3 and necessary tools
yum install vim python-36 virtualenvwrapper git wget curl tree

# Download color scheme
mkdir -p ~/.vim/colors 
wget -O ~/.vim/colors/wombat256mod.vim http://www.vim.org/scripts/download_script.php?src_id=13400

