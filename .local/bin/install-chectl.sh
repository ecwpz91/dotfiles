install-chectl() {
  curl -L 'https://github.com/che-incubator/chectl/releases/download/20190401083124/chectl-linux' \
       -o "$HOME/.local/bin/chectl" \
  && chmod +x "$HOME/.local/bin/chectl"
}
