# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
if [ -f $HOME/.bashrc_exports ]; then
	# shellcheck source=/dev/null
  source $HOME/.bashrc_exports
fi

if [ -f $HOME/.bashrc_aliases ]; then
	# shellcheck source=/dev/null
  source $HOME/.bashrc_aliases
fi
