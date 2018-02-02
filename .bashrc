# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
 . /etc/bashrc
fi

set -o noclobber

if [ -d "$HOME/.profile.d" ]; then
 ARR=( $HOME/.profile.d/* )
 for i in "${ARR[@]}"; do . "${i}"; done
fi
