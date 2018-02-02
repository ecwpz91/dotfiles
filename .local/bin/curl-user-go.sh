curl-user-go() {
 [ ! -d "$HOME/.go" ] && mkdir -p "$HOME/.go"

 curl -L "https://dl.google.com/go/go1.9.3.linux-amd64.tar.gz" \
 | tar -xzf - -C "$HOME/.go" --strip 1
}
