install-dep() {
 curl -L 'https://github.com/golang/dep/releases/download/v0.5.0/dep-linux-amd64' \
      -o "$HOME/.local/bin/dep" \
 && chmod +x "$HOME/.local/bin/dep"
}
