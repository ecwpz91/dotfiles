install-kn() {
 curl -L 'https://mirror.openshift.com/pub/openshift-v4/clients/serverless/latest/kn-linux-amd64-0.18.4.tar.gz' \
 | tar -xvzf - -C "$HOME/.local/bin" &>/dev/null
}
