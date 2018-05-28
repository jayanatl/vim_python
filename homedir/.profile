# Aliases
alias vi='nvim'
alias vim='nvim'
# Virtual env related settings 
export WORKON_HOME=~/.virtualenvs 
VIRTUALENVWRAPPER_PYTHON='~/.local/bin/python3.6' 
source /usr/bin/virtualenvwrapper.sh

# Sync time
echo "Initiating time sync..."
sudo ntpdate -u pool.ntp.org &> /dev/null &

