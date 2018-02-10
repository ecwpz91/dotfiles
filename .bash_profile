# .bash_profile

if [ -f ~/.bashrc ]; then
 . ~/.bashrc
fi

export PATH=$PATH:$HOME/.local/bin:$HOME/bin

if [ -d ~/.profile.d ]; then
 ARR=( $HOME/.profile.d/* ) \
 && for i in "${ARR[@]}"; do . "$i"; done \
 && unset ARR
fi
