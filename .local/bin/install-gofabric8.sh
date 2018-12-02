install-gofabric8() {
 curl -L 'https://github.com/fabric8io/gofabric8/releases/download/v0.4.176/gofabric8-linux-amd64' \
      -o "$HOME/.local/bin/gofabric8" \
 && chmod +x "$HOME/.local/bin/gofabric8"
}
