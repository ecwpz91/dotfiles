install-noobaa() {
 curl -L 'https://github.com/noobaa/noobaa-operator/releases/download/v5.8.0/noobaa-linux-v5.8.0' \
      -o "$HOME/.local/bin/noobaa" \
 && chmod +x "$HOME/.local/bin/noobaa"

 # noobaa completion bash > ~/.profile.d/noobaa.sh
}