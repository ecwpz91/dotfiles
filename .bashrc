# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
 . /etc/bashrc
fi

set -o noclobber

if [ -f $HOME/.bash_export ]; then
 source $HOME/.bash_export
fi

if [ -f $HOME/.bash_alias ]; then
 source $HOME/.bash_alias
fi

if [ -f $HOME/.bash_complete ]; then
 source $HOME/.bash_complete
fi
