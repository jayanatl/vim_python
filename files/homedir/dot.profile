# Aliases
alias vi='nvim'
alias vim='nvim'

# Variable to help detect whether this file is sourced, used in ~/.bashrc
export PROFILELOADED=true

# Load enable ~/.pythonrc
export PYTHONSTARTUP=~/.pythonrc

[[ $(uname) == "Darwin" ]] && {
  # Setup terminal color to match Linux (eg: ls)
  export CLICOLOR=1
  export LSCOLORS=ExGxBxDxCxEgEdxbxgxcxd
}
