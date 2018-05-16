#!/bin/bash
mkdir -p /tmp/repo
pushd /tmp/repo
curl -L https://github.com/jayanatl/vim_python/archive/initial_prototype.zip > repo.zip
yum -y install unzip
unzip repo.zip
rm repo.zip
mv vim_python* ~/.dotfiles
cd ~/.dotfiles
bash setup_centos.sh
popd
