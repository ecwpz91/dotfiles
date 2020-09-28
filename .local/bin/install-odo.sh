install-odo() {
 curl -L 'https://mirror.openshift.com/pub/openshift-v4/clients/odo/latest/odo-linux-amd64' -o "$HOME/.local/bin/odo" \
 && chmod +x "$HOME/.local/bin/odo"
}
