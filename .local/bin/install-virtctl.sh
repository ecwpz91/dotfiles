install-virtctl() {
 curl -L 'https://github.com/kubevirt/kubevirt/releases/download/v0.8.0/virtctl-v0.8.0-linux-amd64' \
      -o "$HOME/.local/bin/virtctl" \
 && chmod +x "$HOME/.local/bin/virtctl"
}
