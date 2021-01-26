install-hey() {
 curl -L 'https://hey-release.s3.us-east-2.amazonaws.com/hey_linux_amd64' \
      -o "$HOME/.local/bin/hey" \
 && chmod +x "$HOME/.local/bin/hey"
}