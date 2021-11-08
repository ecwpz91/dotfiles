install-go() {
 curl -L 'https://golang.org/dl/go1.16.5.linux-amd64.tar.gz' \
 | tar -xvzf - -C "$HOME/.local" --strip 1 &>/dev/null

 # https://golang.org/doc/install/source#tools
}
