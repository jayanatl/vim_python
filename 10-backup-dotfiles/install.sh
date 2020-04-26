#!/bin/bash
###############################################################################
# Script to configure dot files and backup existing files
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
	epoc=$(date +%s)
	DOTBKP="~/.dotfiles_backup/files/${epoch}"
	echo "Baking up dot files that are being replaced"
	for dotfile in $(ls -d files/homedir/dot.*); do
		echo "Here DotFile: ${dotfile}"
		fname=$(basename ${dotfile})
		slink_name=${fname/dot}
		 
		if [ -e "${HOME}/${slink_name}" ]; then
			if ! [ -h "${HOME}/${slink_name} ]; then
				if ! [ -d ${DOTBKP} ]; then
					mkdir -p ${DOTBKP}
				fi
			mv -v "${HOME}/${slink_name}" "${DOTBKP}/"
			fi
		fi
		ln -snvf "${dotfiles}" "${HOME}/${slink_name}"
	done
	# Cleanup brew entry in dot.profile/dot.bashrc
	# Get that entry from current .bashrc/.profile before moving it to backup

	# Create org if not present
	# Create backup if files which are not simlinks to .dotfiles and is getting replaced
	#   and move those to backup folder


elif [[ ${OP} == "uninstall" ]]; then
############################
# Uninstall                #
############################
	echo "Nothing to uninstall, use restore script restore original dot files"
	# Resetore files in reverse order
fi

