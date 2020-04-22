#!/bin/bash
# Script to install and configure neovim on Linux/mac and configure it for python development

# TODO Don't run as root

# Export Repo and branch so that other scripts can use it

# Find OS
OS=$(uname)
if [[ ${OS} == "Linux" ]]; then
  OS=$(grep -w ID /etc/*-release 2>/dev/null|cut -d\" -f2)
fi

case ${OS} in
  Darwin | darwin)
    echo "Mac OS detected"
    echo "Do priliminary stuff needed for Mac"
    ;;

  centos | redhat)
    sudo yum update -y
    sudo yum install git tar python36 gcc -y
    ;;
  
  fedora)
    sudo dnf update -y
    sudo dnf install git tar python37 gcc -y
    ;;
  
  *)
    echo "Sorry, OS: ${OS}, currently not supported by this script"
    ;;
esac


# Install brew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

# Configure brew
if [ ${OS} == "Linux" ]; then
  test -d ~/.linuxbrew && eval $(~/.linuxbrew/bin/brew shellenv)
  test -d /home/linuxbrew/.linuxbrew && eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)
  test -r ~/.bash_profile && echo "eval \$($(brew --prefix)/bin/brew shellenv)" >>~/.bash_profile
  echo "eval \$($(brew --prefix)/bin/brew shellenv)" >>~/.profile
fi

# Install dev tools
source ~/.profile

brew install \
  neovim \
  sipcalc

# Clone repo

# Backup org

# Backup only the files that are being replaced (not links)

# Configure git

# Install plugins

# TODO:
# Cleanup
# Uninstall
# Script should support overriding with a separate repo or branch
# Vim should support spell correction? 

# Setup and use .envrc
# alias git->g
# alias git add -> g a 
# git commit -am -> g cip -am "commit message" etc
# git -> g autocomplete

# Change folders from os to apps/language/tool specific
# Simplify gitconfig
# Template for folder specific bilerplates (.gitignore, .gitconfig?. direnv, etc); don't auto generate
# https://vi.stackexchange.com/questions/9156/what-is-a-more-efficient-way-to-use-buffers
# https://www.reddit.com/r/vim/comments/8553u4/vim_workflow/
