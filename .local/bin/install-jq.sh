install-jq() {
 curl -L https://github.com/stedolan/jq/releases/download/jq-1.5/jq-linux64 \
      -o "$HOME/.local/bin/jq" \
 && chmod +x "$HOME/.local/bin/jq"
}
