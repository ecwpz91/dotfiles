# .bash_profile

if [ -d "$HOME/.profile.d" ]; then
 ARR=( $HOME/.profile.d/* ) \
 && for i in "${ARR[@]}"; do . "$i"; done \
 && unset ARR
fi
