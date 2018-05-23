#!/bin/bash

source ./lib_sh/echos.sh
bot "Hi! I'm going to setup this machine. Here I go..."

bot "Configuring git"
grep 'user = GITHUBUSER' ./homedir/.gitconfig > /dev/null 2>&1
if [[ $? = 0 ]]; then
    read -r -p "What is your github.com username? " githubuser
    read -r -p "What is your first name? " firstname
    read -r -p "What is your last name? " lastname
    read -r -p "What is your email? " email
    fullname="$firstname $lastname"
    bot "Greatings $fullname, "
    sed -i "s/GITHUBFULLNAME/$firstname $lastname/" ./homedir/.gitconfig > /dev/null 2>&1
    sed -i 's/GITHUBEMAIL/'$email'/' ./homedir/.gitconfig
    sed -i 's/GITHUBUSER/'$githubuser'/' ./homedir/.gitconfig
fi

bot "Configuring EPEL Repository"
sudo yum install epel-release -y
sudo yum -y localinstall https://centos7.iuscommunity.org/ius-release.rpm

bot "Update packages"
sudo yum -y update

bot "Install python3 and other necessary tools"
#sudo yum install fzf
sudo yum -y install python-pip python36u python36u-pip git wget curl tree tmux mlocate
mkdir ~/bin
ln -s /usr/bin/python3.6 ~/bin/python3
ln -s /usr/bin/pip3.6 ~/bin/pip3
sudo /usr/bin/pip3.6 install virtualenvwrapper


bot "Installing neovim"
sudo curl -o /etc/yum.repos.d/dperson-neovim-epel-7.repo https://copr.fedorainfracloud.org/coprs/dperson/neovim/repo/epel-7/dperson-neovim-epel-7.repo
sudo yum -y install neovim

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
  echo linking ${file}; ok
done

popd > /dev/null 2>&1


# Configure BASH
mkdir -p ~/bin
grep 'source ~/.profile' ~/.bashrc || echo "source ~/.profile" >> ~/.bashrc
source ~/.bashrc


bot "setting up neovim"

virtualenv --python=python ~/.config/nvim/venv/python2
source ~/.config/nvim/venv/python2/bin/activate
pip install neovim
deactivate

virtualenv --python=python3 ~/.config/nvim/venv/python3
source ~/.config/nvim/venv/python3/bin/activate
pip install neovim
deactivate

nvim -E +PlugInstall +qall
