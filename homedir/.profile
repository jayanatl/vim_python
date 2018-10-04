# Aliases
alias vi='nvim'
alias vim='nvim'
# Virtual env related settings
export WORKON_HOME=~/.virtualenvs
VIRTUALENVWRAPPER_PYTHON='/bin/python3.6'
source ~/.local/bin/virtualenvwrapper.sh

# Sync time
sudo ntpdate -u pool.ntp.org &> /dev/null &

# Load enable ~/.pythonrc
PYTHONSTARTUP=~/.pythonrc
