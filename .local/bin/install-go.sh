install-go() {
 curl -L 'https://dl.google.com/go/go1.11.linux-amd64.tar.gz' \
 | tar -xvzf - -C $HOME/.local --strip 1 &>/dev/null
}
