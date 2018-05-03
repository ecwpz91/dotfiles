install-jq() {
 curl -L https://github.com/stedolan/jq/releases/download/jq-1.5/jq-linux64 \
      -o ~/.local/bin/jq \
 && chmod +x ~/.local/bin/jq
}
