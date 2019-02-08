install-helm() {
 curl -L 'https://storage.googleapis.com/kubernetes-helm/helm-v2.12.3-linux-amd64.tar.gz' \
 | tar -xvzf - -C "$HOME/.local/bin" --strip 1 &>/dev/null
}
