install-helm() {
 curl -L 'https://get.helm.sh/helm-v3.6.2-linux-amd64.tar.gz' \
 | tar -xvzf - -C "$HOME/.local/bin" --strip 1 &>/dev/null
}
