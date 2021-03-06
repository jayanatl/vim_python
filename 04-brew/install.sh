#!/bin/bash
###############################################################################
# Script to install Homebrew
###############################################################################

# Exit incase of any error
set -e

# load common functions
source bin/common.sh

# Sanity check
OP=$(check_operation)

# Permission check
is_no_root
is_sudo

OS=$(this_os)

if [[ ${OP} == "install" ]]; then
############################
# Install                  #
############################
	if is_installed brew; then
		ok "Brew is already installed"
	else
		# Install brew
		yes | /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

		# Configure brew
		if [[ $(uname) == "Linux" ]]; then
			# Cleanup entry if already there
			sed -i "/brew shellenv/d" ~/.profile ~/.bash_profile ~/.bashrc 2>/dev/null || true

			# Add new entries to above files
			test -d ~/.linuxbrew && eval $(~/.linuxbrew/bin/brew shellenv) || true
			test -d /home/linuxbrew/.linuxbrew && eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv) || true
			echo "eval \$($(brew --prefix)/bin/brew shellenv)" | tee -a ~/.bashrc >> ~/.profile
		fi
	fi
elif [[ ${OP} == "uninstall" ]]; then
############################
# Uninstall                #
############################
  # Uninstall any packages installed
    case ${OS} in
      Darwin | darwin)
        echo "Mac OS detected, brew will not be removed"
        ;;

      centos | redhat | fedora)
        echo "Removing linuxbrew configuration"
        sed -i "/brew shellenv/d" ~/.profile ~/.bash_profile ~/.bashrc 2>/dev/null || true
        
	echo "Brew will not be removed"
	# test -d ~/.linuxbrew && sudo rm -rvf ~/.linuxbrew
        # test -d /home/linuxbrew/.linuxbrew && sudo rm -rvf /home/linuxbrew
        ;;
      
      *)
        echo "Sorry, OS: ${OS}, currently not supported by this script"
        exit 127
        ;;
    esac
fi
