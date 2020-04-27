#!/usr/bin/env bash

# Colors
ESC_SEQ="\x1b["
COL_RESET=$ESC_SEQ"39;49;00m"
COL_RED=$ESC_SEQ"31;01m"
COL_GREEN=$ESC_SEQ"32;01m"
COL_YELLOW=$ESC_SEQ"33;01m"
COL_BLUE=$ESC_SEQ"34;01m"
COL_MAGENTA=$ESC_SEQ"35;01m"
COL_CYAN=$ESC_SEQ"36;01m"

function ok() {
    echo -e "$COL_GREEN[ok]$COL_RESET "$1
}

function bot() {
    echo -e "\n$COL_GREEN\[._.]/$COL_RESET - "$1
}

function running() {
    echo -e "$COL_YELLOW Executing $COL_RESET" $1
}

function action() {
    echo -e "\n$COL_YELLOW[$1]$COL_RESET"
}

function warn() {
    echo -e "$COL_YELLOW[warning]$COL_RESET "$1
}

function error() {
    echo -e "$COL_RED[error]$COL_RESET "$1
}

function this_os() {
  # return os name
  OS=$(uname)
  if [[ ${OS} == "Linux" ]]; then
    OS=$(grep -w ID /etc/*-release 2>/dev/null|cut -d\" -f2)
  fi
  echo -e ${OS}
}

function list_install_steps() {
  # List folders which starts with a "number-*" which holds install
  # and uninstall methods
  [[ $1 =~ ^(reverse|rev|r)$ ]] && option="-r" || option=""
  find . -maxdepth 1 -type d -regextype posix-awk -regex "./[0-9]{2}-.*"|cut -d/ -f2|sort $option
}

function check_operation() {
  # Sanity check: Check whether supported operation is invoked
  arg0=${0}
  DNAME=$(dirname ${arg0})
  FNAME=$(basename ${arg0})
  OP=${FNAME/.sh}
  [[ ${OP} =~ ^(install|uninstall)$ ]] || { error Unsupported Operation: ${OP}; exit 127; }
  echo -e ${OP}
}

function is_no_root(){
  (( $UID !=0 )) || { echo "Do not run this as 'root'"; exit 127; }
}

function is_sudo(){
  sudo -l mkdir &>/dev/null || { error "Sudo privillege needed to continue setup"; exit 127; }
}

function user_checks(){
  is_no_root
  is_sudo
}

function is_installed(){
  # Function checks whether executable is available in system path
  compgen -c ${1}| sort -u |grep -w ${1} &>/dev/null && return 0 || return 1
}
