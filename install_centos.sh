#!/bin/bash
rm -rf /tmp/repo &>/dev/null
mkdir -p /tmp/repo
cd /tmp/repo
curl -L https://github.com/jayanatl/vim_python/archive/initial_prototype.zip > repo.zip
yum -y install unzip
unzip repo.zip
rm repo.zip
mv vim_python* ~/.dotfiles
cd ~/.dotfiles
rm -rf /tmp/repo
bash setup_centos.sh
