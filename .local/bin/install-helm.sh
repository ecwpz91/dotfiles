install-helm() {
 curl -L 'https://get.helm.sh/helm-v3.5.0-linux-amd64.tar.gz' \
 | tar -xvzf - -C "$HOME/.local/bin" --strip 1 &>/dev/null
}
