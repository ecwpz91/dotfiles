install-odo() {
 curl -L 'https://github.com/redhat-developer/odo/releases/download/v0.0.14/odo-linux-amd64' -o "$HOME/.local/bin/odo" \
 && chmod +x "$HOME/.local/bin/odo"
}
