install-ko() {
 curl -L 'https://github.com/google/ko/releases/download/v0.7.2/ko_0.7.2_Linux_x86_64.tar.gz' \
 | tar -xvzf - -C "$HOME/.local/bin" &>/dev/null
}