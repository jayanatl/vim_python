#!/bin/bash
# Script to figure out which version of OS the machine is running


_uname=$(uname -s)
case "${_uname}" in
  Linux*)
    machine=linux
    [ -f /etc/redhat-release ] && machine="rhel"
    [ -f /etc/centos-release ] && machine="centos"
    ;;
  Darwin*) machine=mac;;
  *) machine="UNKNOWN:${_uname}"
esac

echo ${machine}

# supported_OS=("mac" "centos" "rhel")
#if [[ " ${supported_OS[@]} " =~ " ${machine} " ]]; then
#  echo ${machine}
#else
#  >&2 echo "Error: "${machine}
#  exit 127
#fi
