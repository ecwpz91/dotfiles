install-openshift-install() {
 curl -L 'https://github.com/openshift/installer/releases/download/v0.11.0/openshift-install-linux-amd64' \
      -o "$HOME/.local/bin/openshift-install" \
 && chmod +x "$HOME/.local/bin/openshift-install"
}
