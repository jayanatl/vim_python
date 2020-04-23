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
    echo -en "$COL_YELLOW ⇒ $COL_RESET"$1": "
}

function action() {
    echo -e "\n$COL_YELLOW[action]:$COL_RESET\n ⇒ $1..."
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
  find . -type d  -maxdepth 1 -regex "\.*/[0-9]\{1,2\}-.*"|cut -d/ -f2|sort $option
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

function check_perms() {
  # Permission check
  (( $UID !=0 )) || { echo "Do not run this as 'root'"; exit 127; }
  sudo -l mkdir 2>/dev/null|| { error "Sudo privillege needed to continue setup"; exit 127; }
  return 0
}
